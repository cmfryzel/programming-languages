#ifndef _COMMISSIONEMPLOYEE_H
#define _COMMISSIONEMPLOYEE_H

#include <string>
#include "Employee.h"

class CommissionEmployee: public Employee {
public:
//    CommissionEmployee();
   CommissionEmployee(const std::string&, const std::string&, const double&, const double&, const double&);
   ~CommissionEmployee() = default; // compiler generates virtual destructor

   double getEarning() const; // pure virtual          
   std::string getInfo() const; // virtual

   void setMinSalary(const double&);
   double getMinSalary() const;

   void setSalesAmount(const double&);
   double getSalesAmount() const;
   
   void setCommissionRate(const double&);
   double getCommissionRate() const;



private:

   double minSalary;
   double salesAmount;
   double commissionRate;
};

#endif

  