#! /bin/sh
cd SlowFast
python tools/run_net.py \
  --cfg configs/masked_ssl/k400_MVITv2_S_16x4_MaskFeat_PT.yaml \
  DATA_LOADER.NUM_WORKERS 0 \
  NUM_GPUS 0 \
  TRAIN.BATCH_SIZE 16 \