import 'package:claveto/common/constant.dart';

import 'package:flutter/material.dart';

enum Parts { head, torso, rightArm, leftArm, legs, fullBody }

class Part {
  Parts part;
  String heroTag;
  int numOfImages;
  List<AssetImage> imageList;
  String imagesFolder;
  bool isPreCached;

  Part({
    @required this.part,
    @required this.heroTag,
    @required this.numOfImages,
    @required this.imageList,
    @required this.imagesFolder,
    @required this.isPreCached,
  });
}

Part head = Part(
  part: Parts.head,
  heroTag: 'head',
  numOfImages: Constants.numOfImagesHead,
  imageList: null,
  imagesFolder: Constants.imagesFolderHead,
  isPreCached: false,
);

Part torso = Part(
  part: Parts.torso,
  heroTag: 'torso',
  numOfImages: Constants.numOfImagesTorso,
  imageList: null,
  imagesFolder: Constants.imagesFolderTorso,
  isPreCached: false,
);

Part rightArm = Part(
  part: Parts.rightArm,
  heroTag: 'rightArm',
  numOfImages: Constants.numOfImagesRightArm,
  imageList: null,
  imagesFolder: Constants.imagesFolderRightArm,
  isPreCached: false,
);

Part leftArm = Part(
  part: Parts.leftArm,
  heroTag: 'leftArm',
  numOfImages: Constants.numOfImagesLeftArm,
  imageList: null,
  imagesFolder: Constants.imagesFolderLeftArm,
  isPreCached: false,
);


Part fullBody = Part(
  part: Parts.fullBody,
  heroTag: 'fullBody',
  numOfImages: Constants.numOfImagesFullBody,
  imageList: null,
  imagesFolder: Constants.imagesFolderFullBody,
  isPreCached: false,
);
Part legs = Part(
  part: Parts.legs,
  heroTag: 'legs',
  numOfImages: Constants.numOfImagesLegs,
  imageList: null,
  imagesFolder: Constants.imagesFolderLegs,
  isPreCached: false,
);
//
// Part fullBody = Part(
//   part: Parts.fullBody,
//   heroTag: 'fullBody',
//   numOfImages: Constants.numOfImagesFullBody,
//   imageList: null,
//   imagesFolder: Constants.imagesFolderFullBody,
//   isPreCached: false,
// );
