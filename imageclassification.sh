#!/bin/bash

# Create a temporary directory to run the image classification
mkdir /tmp/image_classification/

# Copy the image to a local temporary path for processing
cp $YOLO_INPUT/$YOLO_IMAGE_FILENAME /tmp/image_classification/

# Run the image classification
flow --imgdir /tmp/image_classification/ --model $YOLO_CONFIG --load $YOLO_WEIGHTS --threshold $YOLO_THRESHOLD --json && \
flow --imgdir /tmp/image_classification/ --model $YOLO_CONFIG --load $YOLO_WEIGHTS --threshold $YOLO_THRESHOLD

# Make the JSON output ready for processing with Streamsets into MapR-DB
JSON_FILENAME=$(ls /tmp/image_classification/out/*.json)
chmod 666 $JSON_FILENAME
sed -i '1s|^|{"filename": "'$YOLO_IMAGE_FILENAME'","objects":|' $JSON_FILENAME
sed -i '1s|$|}|' $JSON_FILENAME

# Move the image classification output to $$YOLO_OUTPUT
mv /tmp/image_classification/out/* $YOLO_OUTPUT
