package br.com.todo.dao;

import br.com.todo.model.Estado;
import br.com.todo.utils.ConnectionFactory;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class EstadoDAO implements GenericDAO {

    private Connection conn;

    public EstadoDAO() throws Exception {
        try {
            this.conn = ConnectionFactory.getConnection();
        } catch (Exception ex) {
            throw new Exception("Erro: " + ex.getMessage());
        }
    }

    @Override
    public Boolean save(Object object) {
        Estado estado = (Estado) object;
        PreparedStatement stmt = null;
        String sql;

        try {
            if (estado.getCodigo() == null) {
                sql = "INSERT INTO estado (titulo_estado) VALUES (?)";
                stmt = conn.prepareStatement(sql);
                stmt.setString(1, estado.getTitulo());
                stmt.execute();
            } else {
                sql = "UPDATE estado SET titulo_estado = ? WHERE id_estado = ?";
                stmt = conn.prepareStatement(sql);
                stmt.setString(1, estado.getTitulo());
                stmt.setInt(2, estado.getCodigo());
                stmt.execute();
            }
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

    @Override
    public List<Object> select(int idUser, boolean lixeira) {
        List<Object> estados = new ArrayList<Object>();
        PreparedStatement stmt = null;
        ResultSet rs;
        String sql = "SELECT * FROM estado ORDER BY id_estado";

        try {
            stmt = conn.prepareStatement(sql);
            rs = stmt.executeQuery();
            while (rs.next()) {
                Estado estado = new Estado();
                estado.setCodigo(rs.getInt("id_estado"));
                estado.setTitulo(rs.getString("titulo_estado"));
                estados.add(estado);
            }
        } catch (SQLException ex) {
            System.out.println("Erro: " + ex.getMessage());
            ex.printStackTrace();
        } catch (Exception ex) {
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

        return estados;
    }

    @Override
    public Object load(int idUser, int idObject) {
        PreparedStatement stmt = null;
        ResultSet rs = null;
        Estado estado = null;
        String sql = "SELECT * FROM estado WHERE id_estado = ?";

        try {
            stmt = conn.prepareStatement(sql);
            stmt.setInt(1, idObject);
            rs = stmt.executeQuery();
            while(rs.next()) {
                estado = new Estado();
                estado.setCodigo(rs.getInt("id_estado"));
                estado.setTitulo(rs.getString("titulo_estado"));
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

        return estado;
    }

    @Override
    public Boolean delete(int idObject) {
        PreparedStatement stmt = null;
        String sql = "DELETE FROM estado WHERE id_estado = ?";
        try {
            stmt = conn.prepareStatement(sql);
            stmt.setInt(1, idObject);
            stmt.executeUpdate();
            return true;
        } catch (SQLException ex) {
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
    }

    public Estado lastCreated() {
        PreparedStatement stmt = null;
        ResultSet rs = null;
        Estado estado = null;
        String sql = "SELECT * FROM estado ORDER BY id_estado DESC LIMIT 1";

        try {
            stmt = conn.prepareStatement(sql);
            rs = stmt.executeQuery();
            while(rs.next()) {
                estado = new Estado();
                estado.setCodigo(rs.getInt("id_estado"));
                estado.setTitulo(rs.getString("titulo_estado"));
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

        return estado;
    }

}
