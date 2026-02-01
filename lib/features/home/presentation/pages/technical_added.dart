import 'dart:io';

import 'package:deyram_salon/core/theme/app_color.dart';
import 'package:deyram_salon/features/home/presentation/manager/technical_cubit.dart';
import 'package:deyram_salon/features/home/presentation/manager/technical_state.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TechnicianListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Technicians', style: TextStyle(color: Colors.white)),
        backgroundColor: AppColor.lightpink,
        elevation: 2,
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: BlocBuilder<TechnicialCubit, TechnicialState>(
        builder: (context, state) {
          if (state.technicials.isEmpty) {
            return Center(child: Text('No Technicians Added'));
          }

          return ListView.builder(
            padding: EdgeInsets.all(16),
            itemCount: state.technicials.length,
            itemBuilder: (context, index) {
              final technician = state.technicials[index];
              return Card(
                elevation: 4,
                margin: EdgeInsets.only(bottom: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: ListTile(
                  contentPadding: EdgeInsets.all(12),
                  leading: CircleAvatar(
                    backgroundImage:
                        technician.imagePath != null
                            ? FileImage(File(technician.imagePath!))
                            : AssetImage('assets/images/default_avatar.png')
                                as ImageProvider,
                  ),
                  title: Text(
                    technician.name,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Serif',
                    ),
                  ),
                  subtitle: Text(
                    'Category: ${technician.category}\nNumber: ${technician.number}',
                    style: TextStyle(
                      color: Colors.grey[600],
                      fontFamily: 'Serif',
                    ),
                  ),
                  trailing: Icon(
                    Icons.arrow_forward_ios,
                    size: 16,
                    color: Colors.purple,
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
