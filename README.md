# mapr-pacc-image-classification


#### Pull the container
```
docker pull -t mkieboom/mapr-pacc-image-classification .
```


##### Or clone the project...
```
git clone https://github.com/mkieboom/mapr-pacc-image-classification  
cd mapr-pacc-image-classification  
```

#### ...and build the container
```
docker build -t mkieboom/mapr-pacc-image-classification .
```

#### Download the YOLO classification weight and config file
```
# Download the yolo files from the developer at: pjreddie.com/darknet/yolo/

# Or use the following yolo files and place them on MapR-FS:
mkdir /mapr/demo.mapr.com/yolo/
wget http://s3-eu-west-1.amazonaws.com/mkieboom/bootcamp/yolo/tiny-yolo-voc.cfg -P /mapr/demo.mapr.com/yolo/
wget http://s3-eu-west-1.amazonaws.com/mkieboom/bootcamp/yolo/tiny-yolo-voc.weights -P /mapr/demo.mapr.com/yolo/
wget http://s3-eu-west-1.amazonaws.com/mkieboom/bootcamp/yolo/yolo.cfg -P /mapr/demo.mapr.com/yolo/
wget http://s3-eu-west-1.amazonaws.com/mkieboom/bootcamp/yolo/yolo.weights -P /mapr/demo.mapr.com/yolo/
```

#### Run the image classification docker container
```
sudo docker run -i \
	--cap-add SYS_ADMIN \
	--cap-add SYS_RESOURCE \
	--device /dev/fuse \
	-e MAPR_CLUSTER=demo.mapr.com \
	-e MAPR_CLDB_HOSTS=MAPRN01 \
	-e MAPR_CONTAINER_USER=mapr \
	-e MAPR_CONTAINER_GROUP=mapr \
	-e MAPR_CONTAINER_UID=5000 \
	-e MAPR_CONTAINER_GID=5000 \
	-e MAPR_MOUNT_PATH=/mapr \
	-e YOLO_IMAGE_FILENAME=myimage.jpg \
	-e YOLO_INPUT=/my/path/to/image/ \
	-e YOLO_OUTPUT_IMAGE=/my/output/path/for/image/ \
	-e YOLO_OUTPUT_JSON=/my/output/path/for/json/ \
	-e YOLO_CONFIG=/mapr/demo.mapr.com/yolo/yolo.cfg \
	-e YOLO_WEIGHTS=/mapr/demo.mapr.com/yolo/yolo.weights \
	-e YOLO_THRESHOLD=0.1 \
	mkieboom/mapr-pacc-image-classification
```




