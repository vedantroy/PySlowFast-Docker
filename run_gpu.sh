#! /bin/sh
echo "Running on 1 GPUs"
python3 -c 'import torch; print(f"Actual GPUs: {torch.cuda.device_count()}")'
python ./SlowFast/tools/run_net.py --cfg /cfg.yaml
  # --cfg ./SlowFast/configs/masked_ssl/k400_MVITv2_S_16x4_FT_debug.yaml
