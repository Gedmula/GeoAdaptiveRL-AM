"""Feature extractor of the policy network (Stable-Baselines3 MultiInputPolicy).

Two CNNs read the local and global maps, two small MLPs read the action preview and the state
vector, and a final layer merges them into 256 features. The saved model refers to this class
by its module name, so the file name must stay MapExtractor.py.
"""

import torch
from stable_baselines3.common.torch_layers import BaseFeaturesExtractor
from torch import nn


def _conv(channels, widths, strides):
    layers, c = [], channels
    for w, s in zip(widths, strides):
        layers += [nn.Conv2d(c, w, kernel_size=3, stride=s, padding=1), nn.ReLU()]
        c = w
    return nn.Sequential(*layers, nn.Flatten())


class MapExtractor(BaseFeaturesExtractor):
    def __init__(self, observation_space, features_dim=256):
        super().__init__(observation_space, features_dim)
        local = observation_space["local_map"].shape
        glob = observation_space["global_map"].shape
        preview = observation_space["action_preview"].shape
        state = observation_space["state"].shape

        self.local_cnn = _conv(local[0], (32, 64, 64, 64), (1, 2, 2, 2))
        self.global_cnn = _conv(glob[0], (16, 32, 32), (1, 2, 2))
        with torch.no_grad():
            n_local = self.local_cnn(torch.zeros(1, *local)).shape[1]
            n_global = self.global_cnn(torch.zeros(1, *glob)).shape[1]
        self.local_fc = nn.Sequential(nn.Linear(n_local, 256), nn.ReLU())
        self.global_fc = nn.Sequential(nn.Linear(n_global, 128), nn.ReLU())
        self.preview_fc = nn.Sequential(nn.Flatten(), nn.Linear(preview[0] * preview[1], 64), nn.ReLU())
        self.state_fc = nn.Sequential(nn.Linear(state[0], 64), nn.ReLU())
        self.head = nn.Sequential(nn.Linear(256 + 128 + 64 + 64, features_dim), nn.ReLU())

    def forward(self, obs):
        return self.head(torch.cat([
            self.local_fc(self.local_cnn(obs["local_map"])),
            self.global_fc(self.global_cnn(obs["global_map"])),
            self.preview_fc(obs["action_preview"]),
            self.state_fc(obs["state"]),
        ], dim=1))
