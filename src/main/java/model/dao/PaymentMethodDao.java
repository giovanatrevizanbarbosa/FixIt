package model.dao;

import model.Address;
import model.Customer;
import model.PaymentMethod;

import javax.sql.DataSource;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.Optional;

public class PaymentMethodDao {
    private DataSource dataSource;

    public PaymentMethodDao(DataSource dataSource) {
        this.dataSource = dataSource;
    }

    public Optional<PaymentMethod> getPaymentMethodById(Long id) {
        String sql = "select * from payment_method where id = ?";
        Optional<PaymentMethod> optional = Optional.empty();
        try (Connection conn = dataSource.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)
        ){
            stmt.setLong(1, id);
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    PaymentMethod paymentMethod = new PaymentMethod();
                    paymentMethod.setId(rs.getLong("id"));
                    paymentMethod.setName(rs.getString("name"));
                    optional = Optional.of(paymentMethod);
                }
            }
        } catch (SQLException e) {
            throw new RuntimeException("Erro durante a consulta no banco de dados", e);
        }
        return optional;
    }

    public Boolean save(PaymentMethod paymentMethod) {
        Long paymentMethodId = paymentMethod.getId();
        Optional<PaymentMethod> optional = null;

        if(paymentMethodId != null){
            optional = getPaymentMethodById(paymentMethodId);
            if(optional.isPresent()) {
                return false;
            }
        }

        String sql = "insert into payment_method (name) values (?)";
        try(Connection conn = dataSource.getConnection();
            PreparedStatement stmt = conn.prepareStatement(sql)
        ) {
            stmt.setString(1, paymentMethod.getName());
            stmt.executeUpdate();
        } catch (SQLException e) {
            throw new RuntimeException("Erro durante a escrita no banco de dados", e);
        }
        return true;
    }

    public List<PaymentMethod> getAllPaymentMethods() {
        String sql = "select id,name from payment_method";
        ArrayList<PaymentMethod> paymentMethods = new ArrayList<>();
        try(Connection connection = dataSource.getConnection();
            PreparedStatement preparedStatement = connection.prepareStatement(sql)
        ){
            try(ResultSet resultSet = preparedStatement.executeQuery()) {
                while (resultSet.next()){
                    PaymentMethod paymentMethod = new PaymentMethod();
                    paymentMethod.setId(resultSet.getLong("id"));
                    paymentMethod.setName(resultSet.getString("name"));
                    paymentMethods.add(paymentMethod);
                }
            }
        }catch (SQLException e) {
            throw new RuntimeException("Erro durante a consulta no banco de dados", e);
        }
        return paymentMethods;
    }
}
