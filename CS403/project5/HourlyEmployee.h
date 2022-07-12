#ifndef _HOURLYEMPLOYEE_H
#define _HOURLYEMPLOYEE_H

#include <string>
#include "Employee.h"

class HourlyEmployee: public Employee {
public:
   HourlyEmployee(const std::string&, const std::string&, const double&, const double&);
   ~HourlyEmployee() = default; // compiler generates virtual destructor

   double getEarning() const; // pure virtual          
   std::string getInfo() const; // virtual

   void setHoursWorked(const double&);
   double getHoursWorked() const;

   void setHourlyRate(const double&);
   double getHourlyRate() const;

private:
   double hoursWorked;
   double hourlyRate;
};

#endif