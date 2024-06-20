#!/bin/bash

sudo apt update
sudo apt install -y  python3 python3-pip git
git clone https://github.com/sovit-123/fastercnn-pytorch-training-pipeline.git
cd fastercnn-pytorch-training-pipeline || exit
pip install -r --disable-pip-version-check --no-input requirements.txt
pip3 install --disable-pip-version-check --no-input torch torchvision torchaudio --index-url https://download.pytorch.org/whl/cu121
top_dir=$(pwd)
cd data || exit
git clone -b train-val https://github.com/aleksandar-aleksandrov/groceries-object-detection-dataset.git
cd groceries-object-detection-dataset/dataset/ || exit
dataset_dir=$(pwd)
cd train/annotations || exit
mv cake/* candy/* cereal/* chips/* chocolate/* coffee/* corn/* fish/* flour/* honey/* jam/* juice/* milk/* nuts/* oil/* pasta/* rice/* soda/* spices/* sugar/* tea/* tomato_sauce/* vinegar/* water/* beans/* .
rm -r beans cake candy cereal chips chocolate coffee corn fish flour honey jam juice milk nuts oil pasta rice soda spices sugar tea tomato_sauce vinegar water
cd .. 
cd images || exit
mv cake/* candy/* cereal/* chips/* chocolate/* coffee/* corn/* fish/* flour/* honey/* jam/* juice/* milk/* nuts/* oil/* pasta/* rice/* soda/* spices/* sugar/* tea/* tomato_sauce/* vinegar/* water/* beans/* .
rm -r beans cake candy cereal chips chocolate coffee corn fish flour honey jam juice milk nuts oil pasta rice soda spices sugar tea tomato_sauce vinegar water
cd "$dataset_dir" || exit
cd val/annoations || exit
mv cake/* candy/* cereal/* chips/* chocolate/* coffee/* corn/* fish/* flour/* honey/* jam/* juice/* milk/* nuts/* oil/* pasta/* rice/* soda/* spices/* sugar/* tea/* tomato_sauce/* vinegar/* water/* beans/* .
rm -r beans cake candy cereal chips chocolate coffee corn fish flour honey jam juice milk nuts oil pasta rice soda spices sugar tea tomato_sauce vinegar water
cd .. 
cd images || exit
mv cake/* candy/* cereal/* chips/* chocolate/* coffee/* corn/* fish/* flour/* honey/* jam/* juice/* milk/* nuts/* oil/* pasta/* rice/* soda/* spices/* sugar/* tea/* tomato_sauce/* vinegar/* water/* beans/* .
rm -r beans cake candy cereal chips chocolate coffee corn fish flour honey jam juice milk nuts oil pasta rice soda spices sugar tea tomato_sauce vinegar water
cd "$top_dir" || exit
cd data_configs || exit
printf "# Images and labels direcotry should be relative to train.py\nTRAIN_DIR_IMAGES: data/groceries-object-detection-dataset/dataset/train/images\nTRAIN_DIR_LABELS: data/groceries-object-detection-dataset/dataset/train/annotations\n# VALID_DIR should be relative to train.py\nVALID_DIR_IMAGES: data/groceries-object-detection-dataset/dataset/val/images\nVALID_DIR_LABELS: data/groceries-object-detection-dataset/dataset/val/annotations\n# Class names.\nCLASSES: [\n    '__background__',\n    'beans',\n    'cake',\n    'candy',\n    'cereal',\n    'chips',\n    'chocolate',\n    'coffee',\n    'corn',\n    'fish',\n    'flour',\n    'honey',\n    'jam',\n    'juice',\n    'milk',\n    'nuts',\n    'oil',\n    'pasta',\n    'rice',\n    'soda',\n    'spices',\n    'sugar',\n    'tea',\n    'tomato_sauce',\n    'vinegar',\n    'water'\n]\n\n# Number of classes (object classes + 1 for background class in Faster RCNN).\nNC: 26\n\n# Whether to save the predictions of the validation set while training.\nSAVE_VALID_PREDICTION_IMAGES: True" > matura.yaml
cd .. 
python3 train.py --data data_configs/matura.yaml --epochs 50 --model fasterrcnn_resnet50_fpn --name matura_training --batch 16


