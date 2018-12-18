package br.com.todo.dao;

import br.com.todo.model.Usuario;
import br.com.todo.utils.ConnectionFactory;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class UsuarioDAO {

    private Connection conn;

    public UsuarioDAO() throws Exception {
        try {
            this.conn = ConnectionFactory.getConnection();
        } catch (Exception ex) {
            throw new Exception("Problemas ao conectar com o banco! Erro: " + ex.getMessage());
        }
    }

    public Usuario signIn(Usuario usuario) {
        PreparedStatement stmt = null;
        ResultSet rs = null;
        Usuario usu = null;
        String sql = "SELECT * FROM usuario WHERE login_usuario = ? AND senha_usuario = ?";

        try {
            stmt = conn.prepareStatement(sql);
            stmt.setString(1, usuario.getLogin());
            stmt.setString(2, usuario.getSenha());
            rs = stmt.executeQuery();
            while(rs.next()) {
                usu = new Usuario();
                usu.setCodigo(rs.getInt("id_usuario"));
                usu.setNome(rs.getString("nome_usuario"));
                usu.setEmail(rs.getString("email_usuario"));
                usu.setLogin(rs.getString("login_usuario"));
                usu.setSenha(rs.getString("senha_usuario"));
            }
        } catch (SQLException ex) {
            System.out.println("Erro: " + ex.getMessage());
            ex.printStackTrace();
        } finally {
            try {
                ConnectionFactory.closeConnection(conn, stmt);
            } catch (Exception ex) {
                ex.printStackTrace();
                System.out.println("Erro: " + ex.getMessage());
            }
        }

        return usu;
    }

    public Boolean signUp(Usuario usuario) {
        PreparedStatement stmt = null;
        ResultSet rs = null;
        Usuario usu = null;
        String sql = "INSERT INTO usuario (nome_usuario, email_usuario, login_usuario, senha_usuario) " +
                "VALUES (?,?,?,?)";

        try {
            stmt = conn.prepareStatement(sql);
            stmt.setString(1, usuario.getNome());
            stmt.setString(2, usuario.getEmail());
            stmt.setString(3, usuario.getLogin());
            stmt.setString(4, usuario.getSenha());
            stmt.execute();
        } catch (SQLException ex) {
            System.out.println("Erro: " + ex.getMessage());
            ex.printStackTrace();
            return false;
        } catch (Exception ex) {
            System.out.println("Erro: " + ex.getMessage());
            ex.printStackTrace();
            return false;
        } finally {
            try {
                ConnectionFactory.closeConnection(conn, stmt);
            } catch (Exception ex) {
                ex.printStackTrace();
                System.out.println("Erro: " + ex.getMessage());
            }
        }

        return true;
    }

}
