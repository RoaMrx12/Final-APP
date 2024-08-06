import 'package:flutter/material.dart';
import 'package:centro/widgets/base_page.dart';

class AboutUs extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BasePage(
      title: 'About Us',
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '"El futuro pertenece a quienes creen en la belleza de sus sueños."',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 20),
              _buildCard('lib/assets/perfil/DaniaSierra.jpg', 'Dania sierra', '2021-0396'),
              SizedBox(height: 10),
              _buildCard('lib/assets/perfil/Jumairis.jpg', 'Jumairis Encarnación Valdez', '2022-0351'),
              SizedBox(height: 10),
              _buildCard('lib/assets/perfil/MiguelGrullon.jpg', 'Miguel Grullón Reinoso', '2022-0111'),
              SizedBox(height: 10),
              _buildCard('lib/assets/perfil/RobertMachuca.jpg', 'Robert Machuca', '2022-0396'),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCard(String imagePath, String name, String matricula) {
    return Card(
      elevation: 5,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8.0),
              child: Image.asset(
                imagePath,
                width: 60,
                height: 60,
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(width: 16),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  matricula,
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey[600],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
