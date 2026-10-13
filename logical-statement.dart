import 'dart:io';

void main() {
  print('===== Student BMI Checker =====');

  String summary = processStudents(3);

  print('\n===== Summary =====');
  print(summary);
}

String processStudents(int numberOfStudents) {
  int validStudents = 0;
  int invalidStudents = 0;
  int healthyRangeCount = 0;

  for (int i = 1; i <= numberOfStudents; i++) {
    print('\n--- Student $i ---');

    try {
      stdout.write('Enter student name: ');
      String studentName = stdin.readLineSync()!.trim();

      stdout.write('Enter age: ');
      int age = int.parse(stdin.readLineSync()!);

      stdout.write('Enter weight in kilograms: ');
      double weight = double.parse(stdin.readLineSync()!);

      stdout.write('Enter height in meters: ');
      double height = double.parse(stdin.readLineSync()!);

      if (studentName.isEmpty || age <= 0 || weight <= 0 || height <= 0) {
        throw FormatException('Values must be valid and positive.');
      }

      bool isAdult = age >= 18;
      double bmi = calculateBMI(weight, height);
      bool isHealthyWeight = bmi >= 18.5 && bmi <= 24.9;

      print('\nStudent name: $studentName');
      print('Age: $age years old');
      print('Is the student an adult? $isAdult');
      print('BMI: ${bmi.toStringAsFixed(2)}');

      if (bmi < 18.5) {
        print('BMI category: Below the usual healthy adult range');
      } else if (bmi <= 24.9) {
        print('BMI category: Within the usual healthy adult range');
      } else if (bmi < 30) {
        print('BMI category: Above the usual healthy adult range');
      } else {
        print('BMI category: BMI of 30 or higher');
      }

      print(
        'Within the usual healthy adult BMI range? '
        '$isHealthyWeight',
      );

      validStudents++;

      if (isHealthyWeight) {
        healthyRangeCount++;
      }
    } catch (e) {
      print('\nInvalid input!');
      print('Please enter a valid name, age, weight, and height.');
      print('This student record will be skipped.');

      invalidStudents++;
    }
  }

  return 'Total students processed: $numberOfStudents\n'
      'Valid records: $validStudents\n'
      'Invalid records: $invalidStudents\n'
      'Students within the usual healthy adult BMI range: '
      '$healthyRangeCount';
}

double calculateBMI(double weight, double height) {
  return weight / (height * height);
}
