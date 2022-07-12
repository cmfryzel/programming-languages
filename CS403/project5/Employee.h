#ifndef _EMPLOYEE_H
#define _EMPLOYEE_H

#include <string>

class Employee {
public:
   Employee(const std::string&, const std::string&);
   virtual ~Employee() = default; // compiler generates virtual destructor

   void setFirstName(const std::string&);
   std::string getFirstName() const;

   void setLastName(const std::string&);
   std::string getLastName() const;

   virtual double getEarning() const = 0; // pure virtual          
   virtual std::string getInfo() const; // virtual              

private:
   std::string firstName;
   std::string lastName;
};

#endif
