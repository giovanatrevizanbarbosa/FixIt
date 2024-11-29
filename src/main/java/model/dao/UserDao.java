package model.dao;

import model.User;
import utils.PasswordEncoder;

import javax.sql.DataSource;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import java.util.Optional;

public class UserDao {
	private DataSource dataSource;
	
	public UserDao(DataSource dataSource) {
		super();
		this.dataSource = dataSource;
	}
	
	public Optional<User> getUserByEmailAndPassword(String email, String password){
		String passwordEncripted = PasswordEncoder.encode(password);
		System.out.println(password);
		System.out.println(passwordEncripted);
		String sql = "select id,email,active,admin from user where email=? and password=?";

		Optional<User> optional = Optional.empty();
		try (Connection connection = dataSource.getConnection();
			 PreparedStatement preparedStatement = connection.prepareStatement(sql)) {
			preparedStatement.setString(1, email);
			preparedStatement.setString(2, passwordEncripted);
			try (ResultSet resultSet = preparedStatement.executeQuery()) {
				if (resultSet.next()) {
					User user = new User();
					user.setId(resultSet.getLong("id"));
					user.setEmail(resultSet.getString("email"));
					user.setActive(resultSet.getBoolean("active"));
					user.setAdmin(resultSet.getBoolean("admin"));

					optional = Optional.of(user);
				}
			}
		} catch (SQLException sqlException) {
			throw new RuntimeException("Erro durante a consulta no banco de dados", sqlException);
		}
		return optional;
	}
	
	public Optional<User> getUserById(Long id){
		String sql = "select id,email,active,admin from user where id=?";
		Optional<User> optional = Optional.empty();
		try(Connection connection = dataSource.getConnection(); 
				PreparedStatement preparedStatement = connection.prepareStatement(sql)
		){
			preparedStatement.setLong(1, id);
			try(ResultSet resultSet = preparedStatement.executeQuery()) {
				if(resultSet.next()) {
					User user = new User();
					user.setId(resultSet.getLong("id"));
					user.setEmail(resultSet.getString("email"));
					user.setActive(resultSet.getBoolean("active"));
					user.setAdmin(resultSet.getBoolean("admin"));
					optional = Optional.of(user);
				}
			}
		}catch (SQLException e) {
			throw new RuntimeException("Erro durante a consulta no banco de dados", e);
		}
		return optional;
	}

	public Long save(User user){
		Long userId = user.getId();
		Optional<User> optional = null;

		if(userId != null){
			optional = getUserById(userId);
			if(optional.isPresent()) {
				return -1L;
			}
		}

		String sql = "insert into user (email, password, active, admin) values (?,?,?,?)";
		try(Connection connection = dataSource.getConnection();
			PreparedStatement preparedStatement = connection.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
			preparedStatement.setString(1, user.getEmail());
			preparedStatement.setString(2, PasswordEncoder.encode(user.getPassword()));
			preparedStatement.setBoolean(3, true);
			preparedStatement.setBoolean(4, user.getAdmin());
			preparedStatement.executeUpdate();

			ResultSet rs = preparedStatement.getGeneratedKeys();
			if (rs.next()) {
				long generatedId = rs.getLong(1);
				user.setId(generatedId);
				optional = getUserById(generatedId);
			}
		}catch (SQLException e) {
			throw new RuntimeException("Erro durante a escrita no banco de dados", e);
		}

		if (optional != null && optional.isPresent()) {
			return optional.get().getId();
		} else {
			throw new RuntimeException("Falha ao salvar o usuario no banco de dados");
		}
	}

    public List<User> getAllUsers() {
		String sql = "select id,email,active,admin from user";
		ArrayList<User> users = new ArrayList<>();
		try(Connection connection = dataSource.getConnection();
			PreparedStatement preparedStatement = connection.prepareStatement(sql)
		){
			try(ResultSet resultSet = preparedStatement.executeQuery()) {
				while (resultSet.next()){
					User user = new User();
					user.setId(resultSet.getLong("id"));
					user.setEmail(resultSet.getString("email"));
					user.setActive(resultSet.getBoolean("active"));
					user.setAdmin(resultSet.getBoolean("admin"));
					users.add(user);
				}
			}
		}catch (SQLException e) {
			throw new RuntimeException("Erro durante a consulta no banco de dados", e);
		}
		return users;
    }
}