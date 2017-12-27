#!/bin/bash

# Create a temporary directory to run the image classification
mkdir /tmp/image_classification/

# Copy the image to a local temporary path for processing
cp $YOLO_INPUT/$YOLO_IMAGE_FILENAME /tmp/image_classification/

# Run the image classification
flow --imgdir /tmp/image_classification/ --model $YOLO_CONFIG --load $YOLO_WEIGHTS --threshold $YOLO_THRESHOLD --json && \
flow --imgdir /tmp/image_classification/ --model $YOLO_CONFIG --load $YOLO_WEIGHTS --threshold $YOLO_THRESHOLD

# Move the image classification output to $$YOLO_OUTPUT
mv /tmp/image_classification/out/* $YOLO_OUTPUT
