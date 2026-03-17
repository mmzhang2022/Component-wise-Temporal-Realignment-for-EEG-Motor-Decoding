%% ===============================================================
%  Author: Chen et al.
%
%  Description:
%    This script performs EEG component decomposition using the
%    Residue Iteration Decomposition (RIDE) method to separate
%    stimulus-locked (S), central/movement (C/M), and response-locked (R)
%    components from EEG signals.
%
%    Both original (unaligned) and latency-corrected single-trial
%    components are extracted.
%
%  Input:
%    data : Preprocessed EEG data matrix (time × channels × trials)
%    rt   : reaction time vector (trials × 1), unit: ms
%
%  Output:
%    ME_EEG_S           : stimulus-locked component (trials × channels × time)
%    ME_EEG_C           : central/movement component (unaligned)
%    ME_EEG_R           : response component (unaligned)
%    ME_EEG_C_aligned   : latency-corrected central/M component
%    ME_EEG_R_aligned   : latency-corrected response component
%
%  Reference:
%	 RIDE method (residue iteration decomposition) as described by Ouyang et al., 2015.
%	 See details at https://doi.org/10.1016/j.jneumeth.2014.10.009
%
%	 Ouyang, G., Sommer, W. & Zhou, C. A toolbox for residue iteration
%	 decomposition (RIDE)—A method for the decomposition, reconstruction,
%	 and single trial analysis of event-related potentials.
%	 Journal of Neuroscience Methods 250, 7–21 (2015).
% ===============================================================


%% =========================
% 1. Input data
% =========================

data = ...;        % Preprocessed EEG data, shape: [time × channels × trials]
rt   = ...;        % Reaction time, shape: [trials × 1], unit: ms

srate = 256;       % Sampling rate (Hz)

xmin = -0.5;       % Epoch start time relative to cue onset (seconds)
xmax = 2;          % Epoch end time (seconds)


%% =========================
% 2. Configure RIDE parameters
% =========================

cfg = [];

cfg.samp_interval = 1000 / srate;        % Sampling interval (ms)
cfg.epoch_twd     = [xmin*1000 xmax*1000];

cfg.comp.name = {'s','c','r'};           % S: stimulus, C: central, R: response

cfg.comp.twd = { ...
    [-200,300], ...                      % Stimulus component window
    [200,1500], ...                      % Central/movement component window
    [-300,0]};                           % Response component window

cfg.comp.latency = { ...
    0, ...                               % S latency fixed
    'unknown', ...                       % C/M latency estimated
    rt};                                 % R latency defined by RT

cfg = RIDE_cfg(cfg);


%% =========================
% 3. Run RIDE decomposition
% =========================

results = RIDE_call(data, cfg);


%% =========================
% 4. Extract single-trial components
% =========================

trial_num = size(data,3);

% Convert latency from ms to sample points
latency_c_sample = round(results.latency_c / cfg.samp_interval);
latency_r_sample = round((rt - median(rt)) / cfg.samp_interval);

% ---------------------------------------------------------------
% Reconstruct single-trial components (unaligned timeline)
% ---------------------------------------------------------------

% Stimulus component (S)
results.stS = data ...
    - move3(results.c(:, :, ones(1,trial_num)), latency_c_sample) ...
    - move3(results.r(:, :, ones(1,trial_num)), latency_r_sample);

% Central / movement component (C/M)
results.stC = data ...
    - results.s(:, :, ones(1,trial_num)) ...
    - move3(results.r(:, :, ones(1,trial_num)), latency_r_sample);

% Response component (R)
results.stR = data ...
    - results.s(:, :, ones(1,trial_num)) ...
    - move3(results.c(:, :, ones(1,trial_num)), latency_c_sample);


%% =========================
% 5. Latency alignment
% =========================
% Remove trial-to-trial latency variability by shifting components
% back to their canonical latency

results.stC_aligned = move3(results.stC, -latency_c_sample);
results.stR_aligned = move3(results.stR, -latency_r_sample);


%% =========================
% 6. Save decomposition results
% =========================

save('results.mat','results');


%% =========================
% 7. Reformat output dimensions
% =========================
% Convert data from:
%   time × channels × trials
% to:
%   trials × channels × time

ME_EEG_S = permute(results.stS,[3,2,1]);
ME_EEG_C = permute(results.stC,[3,2,1]);
ME_EEG_R = permute(results.stR,[3,2,1]);

ME_EEG_C_aligned = permute(results.stC_aligned,[3,2,1]);
ME_EEG_R_aligned = permute(results.stR_aligned,[3,2,1]);


%% =========================
% 8. Optional: save ML-ready data
% =========================

save('RIDE_single_trial_components.mat', ...
    'ME_EEG_S', ...
    'ME_EEG_C', ...
    'ME_EEG_R', ...
    'ME_EEG_C_aligned', ...
    'ME_EEG_R_aligned');
