package model.dao;

import model.Address;
import model.State;

import javax.sql.DataSource;
import java.sql.*;
import java.util.Optional;

public class AddressDao {
    private DataSource dataSource;

    public AddressDao(DataSource dataSource) {
        super();
        this.dataSource = dataSource;
    }

    public Optional<Address> getAddressById(Long id){
        String sql = "select id,street,number,complement,neighborhood,cep,city,state from address " +
                     "where id=?";
        Optional<Address> optional = Optional.empty();
        try(Connection connection = dataSource.getConnection();
            PreparedStatement preparedStatement = connection.prepareStatement(sql)
        ){
            preparedStatement.setLong(1, id);
            try(ResultSet resultSet = preparedStatement.executeQuery()) {
                if(resultSet.next()) {
                    Address address = new Address();
                    address.setId(resultSet.getLong("id"));
                    address.setStreet(resultSet.getString("street"));
                    address.setNumber(resultSet.getString("number"));
                    address.setComplement(resultSet.getString("complement"));
                    address.setNeighborhood(resultSet.getString("neighborhood"));
                    address.setCep(resultSet.getString("cep"));
                    address.setCity(resultSet.getString("city"));
                    address.setState(State.valueOf(resultSet.getString("state")));
                    optional = Optional.of(address);
                }
            }
        }catch (SQLException e) {
            throw new RuntimeException("Erro durante a consulta no banco de dados", e);
        }
        return optional;
    }

    public Long save(Address address){
        Long addressId = address.getId();
        Optional<Address> optional = null;

        if(addressId != null){
            optional = getAddressById(addressId);
            if(optional.isPresent()) {
                return -1L;
            }
        }

        String sql = "insert into address (street,number,complement,neighborhood,cep,city,state) " +
                "values (?,?,?,?,?,?,?)";

        try (Connection connection = dataSource.getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {

            preparedStatement.setString(1, address.getStreet());
            preparedStatement.setString(2, address.getNumber());
            preparedStatement.setString(3, address.getComplement());
            preparedStatement.setString(4, address.getNeighborhood());
            preparedStatement.setString(5, address.getCep());
            preparedStatement.setString(6, address.getCity());
            preparedStatement.setString(7, address.getState().toString());
            preparedStatement.executeUpdate();

            ResultSet rs = preparedStatement.getGeneratedKeys();
            if (rs.next()) {
                long generatedId = rs.getLong(1);
                address.setId(generatedId);
                optional = getAddressById(generatedId);
            }

        } catch (SQLException e) {
            throw new RuntimeException("Erro durante a escrita no banco de dados", e);
        }

        if (optional != null && optional.isPresent()) {
            return optional.get().getId();
        } else {
            throw new RuntimeException("Falha ao salvar o endereço no banco de dados");
        }
    }
}

