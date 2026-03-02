# Motor-Component-Alignment-EEG

**Official implementation and dataset** for the paper:  
**"Component-wise temporal realignment mitigates latency variability for enhanced EEG motor decoding"**.

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)

## 📄 Abstract
Trial-to-trial latency variability in electroencephalography (EEG), which refers to fluctuations in the timing of neural responses across repeated trials, reduces signal reliability and has a particularly pronounced impact on EEG motor decoding. These fluctuations arise from intrinsic neural dynamics, attentional fluctuations, and cognitive states, which disrupt endogenous (response-locked and motor-related) components without affecting exogenous (stimulus-locked) responses. To address this problem, we introduce a unified component-wise temporal realignment and reconstruction framework that decomposes single-trial EEG signals, realigns functional components based on their intrinsic latencies, and reconstructs temporally coherent event-related potential (ERP) via component recombination. Unlike global alignment methods, our approach preserves component-specific temporal dynamics and avoids distortion from rigid temporal shifts. Validated in unimanual and bimanual motor tasks, our framework restored ERP amplitudes (positive peaks increased from 1.14 to 6.35 µV; negative peaks became more obvious from −1.76 to −5.08 µV) and enhanced phase consistency (phase locking value increased by 107%). Consequently, decoding accuracy improved across six widely used networks, achieving 100.82% relative accuracy in unimanual tasks and 97.53% in bimanual tasks, matching or exceeding optimal sliding-window baselines. These findings establish that correcting component-wise latency variability is critical for recovering true neural dynamics, providing a generalizable strategy for EEG motor BCI applications.

## 🛠️ Requirements

### Python Environment
The deep learning models (EEGNet, ShallowConvNet, etc.) are implemented in Python.
- Python >= 3.8
- TensorFlow
- NumPy, SciPy, Matplotlib
- scikit-learn

### MATLAB Environment
The preprocessing and RIDE decomposition are implemented in MATLAB.
- MATLAB R2020b or later
- EEGLAB Toolbox
- RIDE Toolbox (included or link to source)

## 📂 Repository Structure

```text
Motor-Component-Alignment-EEG/
├── Data/               # Instructions on how to download/organize data
├── Preprocessing/      # MATLAB scripts for RIDE decomposition and alignment
├── Decoding/           # Python scripts for model training (EEGNet, etc.)
├── Utils/              # Helper functions
├── README.md           # This file
└── LICENSE             # MIT License
