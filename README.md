# Employees list

For this task you are given a list of employees. The output of the task is an endpoint which returns the same list of employees but with the relevant country specific information added to each employee.

### Usage

##### Start server
```bash
docker-compose build web
docker-compose up web
```

##### Employees endpoint
`curl -X GET "http://localhost:3000/api/v1/employees" -H  "accept: application/json"`

##### API Documentation (Swagger)
http://localhost:3000/api-docs/index.html

##### Run tests
```bash
docker-compose build web
docker-compose run web bundle exec rspec
```


### Code description

Entry point is API controller [`Api::V1::EmployeesController`](https://github.com/evheny0/employees_platform/blob/master/app/controllers/api/v1/employees_controller.rb) [(spec)](https://github.com/evheny0/employees_platform/blob/master/spec/requests/api/v1/employees_spec.rb). This controller gets a list of employees using [`EmployeesRepository#all`](https://github.com/evheny0/employees_platform/blob/master/app/repositories/employees_repository.rb). The controller fetches country info for every employee using [`ApiClients::Restcountries`](https://github.com/evheny0/employees_platform/blob/master/lib/api_clients/restcountries.rb) [(spec)](https://github.com/evheny0/employees_platform/blob/master/spec/lib/api_clients/restcountries_spec.rb) and converts it into JSON for a response using [`Employees::List::Decorator`](https://github.com/evheny0/employees_platform/blob/master/app/domains/employees/list/decorator.rb) [(spec)](https://github.com/evheny0/employees_platform/blob/master/spec/domains/employees/list/decorator_spec.rb).

[`Employees::List::Decorator`](https://github.com/evheny0/employees_platform/blob/master/app/domains/employees/list/decorator.rb) gets employee info, converts it into a hash, and adds country info to `conutryInfo` field. Also it generates `regionalId` using [`Employees::List::RegionalIdFactory`](https://github.com/evheny0/employees_platform/blob/master/app/domains/employees/list/regional_id_factory.rb) [(spec)](https://github.com/evheny0/employees_platform/blob/master/spec/domains/employees/list/regional_id_factory_spec.rb). `Employees::List::RegionalIdFactory` generates special ids for Europe and Asia and can be extended for other regions or countries.

[`ApiClients::Restcountries`](https://github.com/evheny0/employees_platform/blob/master/lib/api_clients/restcountries.rb) is a simple wrapper for making requests to https://restcountries.com, but it acts as a singleton. It makes a request for specific country info only once, and after that is uses previous info. We can do that since country info does not change very often. Later solutions can utilize any other cache solutions, for example, Redis or storing all countries' data in DB.
