//  const SizedBox(height: 24),
//           const Row(
//             children: [
//               Icon(
//                 Icons.king_bed_rounded,
//                 color: primaryDarkColor,
//               ),
//               SizedBox(width: 10),
//               Text('Select number of bedrooms'),
//             ],
//           ),
//           const SizedBox(
//             height: 10,
//           ),
// SizedBox(
//             height: 60,
//             child: ListView(
//               shrinkWrap: true,
//               scrollDirection: Axis.horizontal,
//               children: [
//                 Center(
//                   child: GestureDetector(
//                     onTap: () {
//                       setState(() {
//                         studioActive = !studioActive;
//                       });
//                     },
//                     child: Container(
//                       margin: const EdgeInsets.only(right: 10),
//                       padding: const EdgeInsets.fromLTRB(15, 5, 15, 5),
//                       decoration: BoxDecoration(
//                           borderRadius: BorderRadius.circular(7),
//                           color: studioActive == true
//                               ? mintyGreen
//                               : Colors.grey.withOpacity(0.2)),
//                       child: Text(
//                         'Studio',
//                         style: Theme.of(context).textTheme.bodyMedium?.copyWith(
//                               color: studioActive == true
//                                   ? Colors.white
//                                   : Colors.black,
//                             ),
//                       ),
//                     ),
//                   ),
//                 ),
//                 Center(
//                   child: GestureDetector(
//                     onTap: () {
//                       setState(() {
//                         oneBedroom = !oneBedroom;
//                       });
//                     },
//                     child: Container(
//                       margin: const EdgeInsets.only(right: 10),
//                       padding: const EdgeInsets.fromLTRB(15, 5, 15, 5),
//                       decoration: BoxDecoration(
//                           borderRadius: BorderRadius.circular(7),
//                           color: oneBedroom == true
//                               ? mintyGreen
//                               : Colors.grey.withOpacity(0.2)),
//                       child: Text(
//                         '1',
//                         style: Theme.of(context).textTheme.bodyMedium?.copyWith(
//                               color: oneBedroom == true
//                                   ? Colors.white
//                                   : Colors.black,
//                             ),
//                       ),
//                     ),
//                   ),
//                 ),
//                 Center(
//                   child: GestureDetector(
//                     onTap: () {
//                       setState(() {
//                         twoBedroom = !twoBedroom;
//                       });
//                     },
//                     child: Container(
//                       margin: const EdgeInsets.only(right: 10),
//                       padding: const EdgeInsets.fromLTRB(15, 5, 15, 5),
//                       decoration: BoxDecoration(
//                           borderRadius: BorderRadius.circular(7),
//                           color: twoBedroom == true
//                               ? mintyGreen
//                               : Colors.grey.withOpacity(0.2)),
//                       child: Text(
//                         '2',
//                         style: Theme.of(context).textTheme.bodyMedium?.copyWith(
//                               color: twoBedroom == true
//                                   ? Colors.white
//                                   : Colors.black,
//                             ),
//                       ),
//                     ),
//                   ),
//                 ),
//                 Center(
//                   child: GestureDetector(
//                     onTap: () {
//                       setState(() {
//                         threeBedroom = !threeBedroom;
//                       });
//                     },
//                     child: Container(
//                       margin: const EdgeInsets.only(right: 10),
//                       padding: const EdgeInsets.fromLTRB(15, 5, 15, 5),
//                       decoration: BoxDecoration(
//                           borderRadius: BorderRadius.circular(7),
//                           color: threeBedroom == true
//                               ? mintyGreen
//                               : Colors.grey.withOpacity(0.2)),
//                       child: Text(
//                         '3',
//                         style: Theme.of(context).textTheme.bodyMedium?.copyWith(
//                               color: threeBedroom == true
//                                   ? Colors.white
//                                   : Colors.black,
//                             ),
//                       ),
//                     ),
//                   ),
//                 ),
//                 Center(
//                   child: GestureDetector(
//                     onTap: () {
//                       setState(() {
//                         fourBedroom = !fourBedroom;
//                       });
//                     },
//                     child: Container(
//                       margin: const EdgeInsets.only(right: 10),
//                       padding: const EdgeInsets.fromLTRB(15, 5, 15, 5),
//                       decoration: BoxDecoration(
//                           borderRadius: BorderRadius.circular(7),
//                           color: fourBedroom == true
//                               ? mintyGreen
//                               : Colors.grey.withOpacity(0.2)),
//                       child: Text(
//                         '4',
//                         style: Theme.of(context).textTheme.bodyMedium?.copyWith(
//                               color: fourBedroom == true
//                                   ? Colors.white
//                                   : Colors.black,
//                             ),
//                       ),
//                     ),
//                   ),
//                 ),
//                 Center(
//                   child: GestureDetector(
//                     onTap: () {
//                       setState(() {
//                         fiveBedroom = !fiveBedroom;
//                       });
//                     },
//                     child: Container(
//                       margin: const EdgeInsets.only(right: 10),
//                       padding: const EdgeInsets.fromLTRB(15, 5, 15, 5),
//                       decoration: BoxDecoration(
//                           borderRadius: BorderRadius.circular(7),
//                           color: fiveBedroom == true
//                               ? mintyGreen
//                               : Colors.grey.withOpacity(0.2)),
//                       child: Text(
//                         '5',
//                         style: Theme.of(context).textTheme.bodyMedium?.copyWith(
//                               color: fiveBedroom == true
//                                   ? Colors.white
//                                   : Colors.black,
//                             ),
//                       ),
//                     ),
//                   ),
//                 ),
//                 Center(
//                   child: GestureDetector(
//                     onTap: () {
//                       setState(() {
//                         sixBedroom = !sixBedroom;
//                       });
//                     },
//                     child: Container(
//                       margin: const EdgeInsets.only(right: 10),
//                       padding: const EdgeInsets.fromLTRB(15, 5, 15, 5),
//                       decoration: BoxDecoration(
//                           borderRadius: BorderRadius.circular(7),
//                           color: sixBedroom == true
//                               ? mintyGreen
//                               : Colors.grey.withOpacity(0.2)),
//                       child: Text(
//                         '6',
//                         style: Theme.of(context).textTheme.bodyMedium?.copyWith(
//                               color: sixBedroom == true
//                                   ? Colors.white
//                                   : Colors.black,
//                             ),
//                       ),
//                     ),
//                   ),
//                 ),
//                 Center(
//                   child: GestureDetector(
//                     onTap: () {
//                       setState(() {
//                         sevenBedroom = !sevenBedroom;
//                       });
//                     },
//                     child: Container(
//                       margin: const EdgeInsets.only(right: 10),
//                       padding: const EdgeInsets.fromLTRB(15, 5, 15, 5),
//                       decoration: BoxDecoration(
//                           borderRadius: BorderRadius.circular(7),
//                           color: sevenBedroom == true
//                               ? mintyGreen
//                               : Colors.grey.withOpacity(0.2)),
//                       child: Text(
//                         '7',
//                         style: Theme.of(context).textTheme.bodyMedium?.copyWith(
//                               color: sevenBedroom == true
//                                   ? Colors.white
//                                   : Colors.black,
//                             ),
//                       ),
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),