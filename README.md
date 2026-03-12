# Component-wise-Temporal-Realignment-for-EEG-Motor-Decoding

**Official implementation and dataset** for the paper:  
**"Component-wise temporal realignment mitigates latency variability for enhanced EEG motor decoding"**.

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)

## 📄 Abstract
Trial-to-trial latency variability in electroencephalography (EEG), which refers to fluctuations in the timing of neural responses across repeated trials, reduces signal reliability and has a particularly pronounced impact on EEG motor execution decoding. These fluctuations arise from intrinsic neural dynamics, attentional fluctuations, and cognitive states, which disrupt endogenous (response-locked and motor-related) components without affecting exogenous (stimulus-locked) responses. To address this problem, we introduce a unified component-wise temporal realignment and reconstruction framework. Our approach decomposes single-trial EEG signals, realigns functional components based on their intrinsic latencies, and reconstructs temporally coherent event-related potential (ERP) via component recombination. By operating at the component level, our method preserves component-specific temporal dynamics and avoids distortion from rigid temporal shifts. Validated in unimanual and bimanual motor tasks, our framework restored ERP amplitudes (positive peaks increased ~6-fold, negative peaks ~3-fold) and doubled phase consistency. Our method achieves results comparable to or exceeding the optimal baseline across six network architectures (reaching 101% for unimanual tasks and 97.5% for bimanual tasks), whereas the baseline method itself—exhaustive window search—requires post hoc optimization and is impractical for real-world use. These findings establish that correcting component-wise latency variability is critical for recovering temporally coherent neural dynamics, and provides a generalizable strategy for EEG motor brain-computer interfaces (BCIs).

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
