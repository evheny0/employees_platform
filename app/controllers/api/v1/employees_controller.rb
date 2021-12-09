module Api
  module V1
    class EmployeesController < Api::V1::ApplicationController
      def index
        employees = EmployeesRepository.new.all.map do |employee|
          country = ApiClients::Restcountries.instance.by_code(employee.country)
          Employees::List::Decorator.new(employee, country).as_json
        end

        render json: employees
      end
    end
  end
end
