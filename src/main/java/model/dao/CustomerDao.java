package model.dao;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import java.util.Optional;

import javax.sql.DataSource;

import model.Address;
import model.Customer;
import utils.PasswordEncoder;

public class CustomerDao {
	private DataSource dataSource;
	
	public CustomerDao(DataSource dataSource) {
		super();
		this.dataSource = dataSource;
	}
	
	public Optional<Customer> getCustomerByEmailAndPassword(String email, String password){
		String passwordEncripted = PasswordEncoder.encode(password);
		
		String sql = "select id,name,email,active from customer where email=? and password=?";
		Optional<Customer> optional = Optional.empty();
		try (Connection connection = dataSource.getConnection(); PreparedStatement preparedStatement = connection.prepareStatement(sql)) {
			preparedStatement.setString(1, email);
			preparedStatement.setString(2, passwordEncripted);
			try (ResultSet resultSet = preparedStatement.executeQuery()) {
				if (resultSet.next()) {
					Customer customer = new Customer();
					customer.setId(resultSet.getLong("id"));
					customer.setName(resultSet.getString("name"));
					customer.setEmail(resultSet.getString("email"));
					customer.setActive(resultSet.getBoolean("active"));
					optional = Optional.of(customer);
				}
			}
			return optional;
		} catch (SQLException sqlException) {
			throw new RuntimeException("Erro durante a consulta no banco de dados", sqlException);
		}
	}
	
	public Optional<Customer> getCustomerById(Long id){
		String sql = "select id,name,email,active,phone,address_id from customer where id=?";
		Optional<Customer> optional = Optional.empty();
		try(Connection connection = dataSource.getConnection(); 
				PreparedStatement preparedStatement = connection.prepareStatement(sql)
		){
			preparedStatement.setLong(1, id);
			try(ResultSet resultSet = preparedStatement.executeQuery()) {
				if(resultSet.next()) {
					Customer customer = new Customer();
					customer.setId(resultSet.getLong("id"));
					customer.setName(resultSet.getString("name"));
					customer.setEmail(resultSet.getString("email"));
					customer.setActive(resultSet.getBoolean("active"));
					customer.setPhone(resultSet.getString("phone"));

					AddressDao addressDao = new AddressDao(dataSource);
					customer.setAddress(addressDao.getAddressById(resultSet.getLong("address_id")).get());
					optional = Optional.of(customer);
				}
			}
		}catch (SQLException e) {
			throw new RuntimeException("Erro durante a consulta no banco de dados", e);
		}
		return optional;
	}
	
	public Long save(Customer customer){
		Long customerId = customer.getId();
		Optional<Customer> optional = null;

		if(customerId != null){
			optional = getCustomerById(customerId);
			if(optional.isPresent()) {
				return -1L;
			}
		}

		String sql = "insert into customer (name, email, password, phone, cpf, active, address_id) values (?,?,?,?,?,?,?)";
		try(Connection connection = dataSource.getConnection();
			PreparedStatement preparedStatement = connection.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
			preparedStatement.setString(1, customer.getName());
			preparedStatement.setString(2, customer.getEmail());
			preparedStatement.setString(3, PasswordEncoder.encode(customer.getPassword()));
			preparedStatement.setString(4, customer.getPhone());
			preparedStatement.setString(5, customer.getCpf());
			preparedStatement.setBoolean(6, true);
			preparedStatement.setLong(7, customer.getAddress().getId());
			preparedStatement.executeUpdate();

			ResultSet rs = preparedStatement.getGeneratedKeys();
			if (rs.next()) {
				long generatedId = rs.getLong(1);
				customer.setId(generatedId);
				optional = getCustomerById(generatedId);
			}
		}catch (SQLException e) {
			throw new RuntimeException("Erro durante a escrita no banco de dados", e);
		}

		if (optional != null && optional.isPresent()) {
			return optional.get().getId();
		} else {
			throw new RuntimeException("Falha ao salvar o cliente no banco de dados");
		}
	}

    public List<Customer> getAllCustomers() {
		String sql = "select id,name,email,active from customer";
		ArrayList<Customer> customers = new ArrayList<>();
		try(Connection connection = dataSource.getConnection();
			PreparedStatement preparedStatement = connection.prepareStatement(sql)
		){
			try(ResultSet resultSet = preparedStatement.executeQuery()) {
				while (resultSet.next()){
					Customer customer = new Customer();
					customer.setId(resultSet.getLong("id"));
					customer.setName(resultSet.getString("name"));
					customer.setEmail(resultSet.getString("email"));
					customer.setActive(resultSet.getBoolean("active"));
					customers.add(customer);
				}
			}
		}catch (SQLException e) {
			throw new RuntimeException("Erro durante a consulta no banco de dados", e);
		}
		return customers;
    }
}