# Employees list

For this task you are given a list of employees. The output of the task is an endpoint which returns the same list of employees but with the relevant country specific information added to each employee.

# Code description

Entry point is API controller [`Api::V1::EmployeesController`](https://github.com/evheny0/employees_platform/blob/master/app/controllers/api/v1/employees_controller.rb)[(spec)](https://github.com/evheny0/employees_platform/blob/master/spec/requests/api/v1/employees_spec.rb). This controller gets a list of employees using [`EmployeesRepository#all`](https://github.com/evheny0/employees_platform/blob/master/app/repositories/employees_repository.rb). For every employee controller fetch country info using [`ApiClients::Restcountries`](https://github.com/evheny0/employees_platform/blob/master/lib/api_clients/restcountries.rb) and convert into JSON for response using [Employees::List::Decorator](https://github.com/evheny0/employees_platform/blob/master/app/domains/employees/list/decorator.rb).
