package model.dao;

import model.Customer;
import model.ServiceOrder;
import model.State;
import model.Status;

import javax.sql.DataSource;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import java.util.Optional;

public class ServiceOrderDao {
    private DataSource dataSource;

    public ServiceOrderDao(DataSource dataSource) {
        this.dataSource = dataSource;
    }

    public Optional<ServiceOrder> getServiceOrderById(Long id) {
        String sql = "select * from service_order where id = ?";
        Optional<ServiceOrder> optional = Optional.empty();
        try (Connection conn = dataSource.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)
        ){
            stmt.setLong(1, id);
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    ServiceOrder serviceOrder = new ServiceOrder();
                    serviceOrder.setDescription(rs.getString("description"));
                    serviceOrder.setObservation(rs.getString("observation"));
                    serviceOrder.setEmissionDate(rs.getDate("emission_date").toLocalDate());
                    serviceOrder.setPrice(rs.getDouble("price"));
                    serviceOrder.setStatus(Status.valueOf(rs.getString("status")));

                    CustomerDao customerDao = new CustomerDao(dataSource);
                    serviceOrder.setCustomer(customerDao.getCustomerById(rs.getLong("customer_id")).get());

                    PaymentMethodDao paymentMethodDao = new PaymentMethodDao(dataSource);
                    serviceOrder.setPaymentMethod(paymentMethodDao.getPaymentMethodById(rs.getLong("payment_method_id")).get());

                    optional = Optional.of(serviceOrder);
                }
            }
        } catch (SQLException e) {
            throw new RuntimeException("Erro durante a consulta no banco de dados", e);
        }
        return optional;
    }

    public Boolean save(ServiceOrder serviceOrder) {
        Long serviceOrderId = serviceOrder.getId();
        Optional<ServiceOrder> optional = null;

        if(serviceOrderId != null){
            optional = getServiceOrderById(serviceOrderId);
            if(optional.isPresent()) {
                return false;
            }
        }

        String sql = "insert into service_order (description,emission_date,completion_date," +
                "value,observation,payment_method_id,status,customer_id) values (?,?,?,?,?,?,?,?)";
        try(Connection conn = dataSource.getConnection();
            PreparedStatement stmt = conn.prepareStatement(sql)
        ) {
            stmt.setString(1, serviceOrder.getDescription());
            stmt.setDate(2, Date.valueOf(serviceOrder.getEmissionDate()));
            stmt.setDate(3, null);
            stmt.setDouble(4, serviceOrder.getPrice());
            stmt.setString(5, serviceOrder.getObservation());
            stmt.setLong(6, serviceOrder.getPaymentMethod().getId());
            stmt.setString(7, serviceOrder.getStatus().toString());
            stmt.setLong(8, serviceOrder.getCustomer().getId());
            stmt.executeUpdate();
        } catch (SQLException e) {
            throw new RuntimeException("Erro durante a escrita no banco de dados", e);
        }
        return true;
    }

    public List<ServiceOrder> getAllServiceOrders() {
        String sql = "select * from service_order";
        ArrayList<ServiceOrder> paymentMethods = new ArrayList<>();
        try(Connection connection = dataSource.getConnection();
            PreparedStatement preparedStatement = connection.prepareStatement(sql)
        ){
            try(ResultSet resultSet = preparedStatement.executeQuery()) {
                while (resultSet.next()){
                    ServiceOrder serviceOrder = new ServiceOrder();
                    serviceOrder.setId(resultSet.getLong("id"));
                    serviceOrder.setDescription(resultSet.getString("description"));
                    serviceOrder.setEmissionDate(resultSet.getDate("emission_date").toLocalDate());
                    Date completionDate = resultSet.getDate("completion_date");
                    if(completionDate != null){
                        serviceOrder.setEmissionDate(completionDate.toLocalDate());
                    }
                    serviceOrder.setPrice(resultSet.getDouble("value"));
                    serviceOrder.setStatus(Status.valueOf(resultSet.getString("status")));
                    serviceOrder.setObservation(resultSet.getString("observation"));

                    PaymentMethodDao paymentMethodDao = new PaymentMethodDao(dataSource);
                    serviceOrder.setPaymentMethod(paymentMethodDao.getPaymentMethodById(resultSet.getLong("payment_method_id")).get());

                    CustomerDao customerDao = new CustomerDao(dataSource);
                    serviceOrder.setCustomer(customerDao.getCustomerById(resultSet.getLong("customer_id")).get());

                    paymentMethods.add(serviceOrder);
                }
            }
        }catch (SQLException e) {
            throw new RuntimeException("Erro durante a consulta no banco de dados", e);
        }
        return paymentMethods;
    }
}
