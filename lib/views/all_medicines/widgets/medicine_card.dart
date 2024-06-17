import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pharmacy/views/all_medicines/model/medicine_model.dart';
import 'package:pharmacy/views/auth/widget/button.dart';
import 'package:skeletons/skeletons.dart';

class MedicineCard extends StatelessWidget {
  final MedicineModel medicine;
  final VoidCallback onTap;

  const MedicineCard({super.key, required this.medicine, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 343.w,
      height: 150.h,
      padding: EdgeInsets.symmetric(horizontal: 10.w, ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: const [
          BoxShadow(color: Color(0x406b6b6b), spreadRadius: 1, blurRadius: 5),
        ],
      ),
      child: Row(
        children: [
          // Medicine Image
          SizedBox(
            width: 120.w,
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 10.w, ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16.r),
                child: CachedNetworkImage(
                  imageBuilder: (context, imageProvider) => Container(

                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: imageProvider,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  imageUrl: medicine.image,
                  placeholder: (context, url) => SkeletonAvatar(
                    style: SkeletonAvatarStyle(width: 120.w),
                  ),
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                ),
              ),
            ),
          ),
          SizedBox(width: 20.w),
          // Medicine Details
          Expanded(
            child: Padding(
              padding:  EdgeInsets.symmetric(vertical: 10.w,),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
               // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          medicine.name,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20.sp,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      SizedBox(width: 8.w),
                      // Text(
                      //   '${medicine.price}',
                      //   style: TextStyle(
                      //     fontWeight: FontWeight.bold,
                      //     fontSize: 14.sp,
                      //     color: Colors.blue,
                      //   ),
                      // ),
                    ],
                  ),
                  SizedBox(height: 10.h,),
                  Text(
                    medicine.description,
                    style: TextStyle(
                      fontWeight: FontWeight.normal,
                      fontSize: 15.sp,
                      color: Colors.grey.shade600
                    ),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 3,
                  ),
                  Spacer(),
                  Align(
                    alignment: Alignment.bottomRight,
                    child: SizedBox(
                      width: 100.w,
                      height: 30.h,
                      child:
                      buttonWidget(onTap: onTap, text: 'Request', ),

                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
