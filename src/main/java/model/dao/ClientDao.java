package model.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Optional;

import javax.sql.DataSource;

import model.Customer;
import utils.PasswordEncoder;

public class ClientDao {
	private DataSource dataSource;
	
	public ClientDao(DataSource dataSource) {
		super();
		this.dataSource = dataSource;
	}
	
	public Optional<Customer> getClientByEmailAndPassword(String email, String password){
		String passwordEncripted = PasswordEncoder.encode(password);
		
		String sql = "select id,name,email,active from client where email=? and password=?";
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
	
	public Optional<Customer> getClientByEmail(String email){
		String sql = "select id,name,email,active from client where email=?";
		Optional<Customer> optional = Optional.empty();
		try(Connection connection = dataSource.getConnection(); 
				PreparedStatement preparedStatement = connection.prepareStatement(sql)
		){
			preparedStatement.setString(1, email);
			try(ResultSet resultSet = preparedStatement.executeQuery()) {
				if(resultSet.next()) {
					Customer customer = new Customer();
					customer.setId(resultSet.getLong("id"));
					customer.setName(resultSet.getString("name"));
					customer.setEmail(resultSet.getString("email"));
					customer.setActive(resultSet.getBoolean("active"));
					optional = Optional.of(customer);
				}
			}
		}catch (SQLException e) {
			throw new RuntimeException("Erro durante a consulta no banco de dados", e);
		}
		return optional;
	}
	
	public Boolean save(Customer customer){
		Optional<Customer> optional = getClientByEmail(customer.getEmail());
		if(optional.isPresent()) {
			return false;
		}
		String sql = "insert into client (name, email, password, phone, cpf, active) values (?,?,?,?,?,?)";
		try(Connection connection = dataSource.getConnection(); 
				PreparedStatement preparedStatement = connection.prepareStatement(sql)){
			preparedStatement.setString(1, customer.getName());
			preparedStatement.setString(2, customer.getEmail());
			preparedStatement.setString(3, PasswordEncoder.encode(customer.getPassword()));
			preparedStatement.setString(4, customer.getPhone());
			preparedStatement.setString(5, customer.getCpf());
			preparedStatement.setBoolean(6, true);
			preparedStatement.executeUpdate();
		}catch (SQLException e) {
			throw new RuntimeException("Erro durante a escrita no banco de dados", e);
		}
		return true;
	}
}