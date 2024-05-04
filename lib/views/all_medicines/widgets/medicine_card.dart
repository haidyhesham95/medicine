import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:pharmacy/views/all_medicines/model/medicine_model.dart';
import 'package:skeletons/skeletons.dart';

class MedicineCard extends StatelessWidget {
  final MedicineModel medicine;
  const MedicineCard({super.key,required this.medicine});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 343,
      height: 150,
      padding: EdgeInsetsDirectional.symmetric(horizontal: 16,vertical: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadiusDirectional.circular(16),
        boxShadow: [BoxShadow(color: Color(0x406b6b6b),spreadRadius: 1,blurRadius: 5)]
      ),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        children: [
          SizedBox(
            width: 120,
              child: ClipRRect(
            borderRadius: BorderRadiusDirectional.circular(16),
              child: CachedNetworkImage(
                imageBuilder: (context, imageProvider) => Container(
                  width: double.infinity,
                  //   height: 150.0,
                  decoration: BoxDecoration(
                    image: DecorationImage(image: imageProvider, fit: BoxFit.fill),
                  ),
                ),
                imageUrl: medicine.image,
                placeholder: (context, url) => const SkeletonAvatar(
                  style: SkeletonAvatarStyle( width: 120),
                ),
                errorWidget: (context, url, error) => const Icon(Icons.error),
              ))),
          SizedBox(width: 20,),
          SizedBox(
            width: 230,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(medicine.name,style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),),
                Text(medicine.description,style: TextStyle(fontWeight: FontWeight.normal,fontSize: 16,color: Colors.grey),overflow: TextOverflow.ellipsis,maxLines: 3,),
                Align(alignment:AlignmentDirectional.bottomEnd,child: Text(medicine.price)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
