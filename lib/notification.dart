import 'package:flutter/material.dart';

class notification extends StatelessWidget {
  const notification({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9FAFB), // لون خلفية قريب من التصميم
      appBar: AppBar(
        backgroundColor: Colors.teal.shade700,
        elevation: 0,
        titleSpacing: 16,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Text("Hi Ahmed", style: TextStyle(fontSize: 16, color: Colors.white70)),
            SizedBox(height: 4),
            Text("Good Morning",
                style: TextStyle(fontSize: 22, color: Colors.white, fontWeight: FontWeight.bold)),
          ],
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context); // This will return to the previous screen
          },
        ),
        actions: [
          IconButton(
            onPressed: () {
              // You can add any functionality for the notification icon here if needed.
            },
            icon: const Icon(Icons.notifications_outlined, color: Colors.white),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: const [
            // البطاقة الأولى
            NotificationCard(
              circleIcon: Icons.notifications,
              circleBorderColor: Colors.purple,
              circleIconColor: Colors.purple,
              title: "Exclusive Deal",
              description:
              "Exclusive Deal! Get 20% off at Metro market today only.",
              time: "2 hours ago",
              brandName: "Metro Market",
              brandLogoUrl:
              "https://metro-website-images.s3.eu-west-1.amazonaws.com/plugins/user/images/about9.png",
            ),

            // البطاقة الثانية
            NotificationCard(
              circleIcon: Icons.notifications,
              circleBorderColor: Colors.orange,
              circleIconColor: Colors.orange,
              title: "Reminders 🛎",
              description:
              "Don't forget! Your cart is waiting for you. Complete your order now.",
              time: "2 hours ago",
            ),

            // البطاقة الثالثة
            NotificationCard(
              circleIcon: Icons.star,
              circleBorderColor: Color(0xFFFBB040),
              circleIconColor: Color(0xFFFBB040),
              title: "🛍 Celebrate Ramadan with Big",
              description:
              "Ramadan Kareem! Enjoy special offers on groceries and essentials.",
              time: "2 days ago",
              imageUrl:
              "https://bsmedia.business-standard.com/_media/bs/img/article/2024-03/07/full/1709813638-2896.png?im=FeatureCrop,size=(826,465)",
            ),
          ],
        ),
      ),
    );
  }
}

class NotificationCard extends StatelessWidget {
  // خصائص الدائرة
  final IconData circleIcon;
  final Color? circleBorderColor;
  final Color? circleIconColor;

  // خصائص المحتوى
  final String title;
  final String description;
  final String time;

  // خصائص إضافية
  final String? brandName;
  final String? brandLogoUrl; // شعار المتجر
  final String? imageUrl;     // أي صورة إضافية

  const NotificationCard({
    super.key,
    required this.circleIcon,
    required this.title,
    required this.description,
    required this.time,
    this.circleBorderColor,
    this.circleIconColor,
    this.brandName,
    this.brandLogoUrl,
    this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      // لون البطاقة أبيض بحد خفيف
      color: Colors.white,
      elevation: 1,
      margin: const EdgeInsets.symmetric(vertical: 8),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // العنوان + الدائرة
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // الدائرة
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: circleBorderColor ?? Colors.transparent,
                      width: 2,
                    ),
                  ),
                  child: Icon(
                    circleIcon,
                    color: circleIconColor ?? Colors.teal,
                    size: 20,
                  ),
                ),
                const SizedBox(width: 8),

                // العنوان
                Expanded(
                  child: Text(
                    title,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 4),

            // وصف الإشعار
            Text(
              description,
              style: const TextStyle(
                fontSize: 14,
                color: Colors.black87,
              ),
            ),

            // شعار المتجر + اسمه (إن وجد)
            if (brandName != null && brandLogoUrl != null) ...[
              const SizedBox(height: 8),
              Row(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Image.network(
                      brandLogoUrl!,
                      width: 40,
                      height: 40,
                      fit: BoxFit.contain,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    brandName!,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                ],
              ),
            ],

            // الصورة إن وجدت
            if (imageUrl != null) ...[
              const SizedBox(height: 8),
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.network(
                  imageUrl!,
                  fit: BoxFit.contain, // لضمان ظهورها كاملة
                ),
              ),
            ],

            const SizedBox(height: 8),

            // الوقت
            Text(
              time,
              style: const TextStyle(
                fontSize: 12,
                color: Colors.black54,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
