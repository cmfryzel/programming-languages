#ifndef _SALARIEDEMPLOYEE_H
#define _SALARIEDEMPLOYEE_H

#include <string>
#include "Employee.h"

class SalariedEmployee: public Employee {
public:
   //SalariedEmployee();
   SalariedEmployee(const std::string&, const std::string&, const double&);
   ~SalariedEmployee() = default; // compiler generates virtual destructor

   double getEarning() const; // pure virtual          
   std::string getInfo() const; // virtual

//    void setHoursWorked(const double&);
//    double getHoursWorked() const;

   void setSalariedRate(const double&);
   double getSalariedRate() const;

    std::string truncate() const;
    
private:
   double salariedRate;
};

#endif