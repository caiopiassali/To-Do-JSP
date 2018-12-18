package br.com.todo.dao;

import br.com.todo.model.Estado;
import br.com.todo.model.Tarefa;
import br.com.todo.utils.ConnectionFactory;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class TarefaDAO implements GenericDAO {

    private Connection conn;

    public TarefaDAO() throws Exception {
        try {
            this.conn = ConnectionFactory.getConnection();
        } catch (Exception ex) {
            throw new Exception("Erro: " + ex.getMessage());
        }
    }

    @Override
    public Boolean save(Object object) throws Exception {
        Tarefa tarefa = (Tarefa) object;
        PreparedStatement stmt = null;
        String sql;

        try {
            if (tarefa.getCodigo() == null) {
                sql = "INSERT INTO tarefa (titulo_tarefa, texto_tarefa, codigo_estado, codigo_usuario, lixeira) " +
                    "VALUES (?,?,?,?,?)";
                stmt = conn.prepareStatement(sql);
                stmt.setString(1, tarefa.getTitulo());
                stmt.setString(2, tarefa.getTexto());
                stmt.setInt(3, tarefa.getEstado().getCodigo());
                stmt.setInt(4, tarefa.getUsuario().getCodigo());
                stmt.setBoolean(5, tarefa.getLixeira());
                stmt.execute();
            } else {
                sql = "UPDATE tarefa SET titulo_tarefa = ?, texto_tarefa = ?, codigo_estado = ?, lixeira = ? WHERE id_tarefa = ?";
                stmt = conn.prepareStatement(sql);
                stmt.setString(1, tarefa.getTitulo());
                stmt.setString(2, tarefa.getTexto());
                stmt.setInt(3, tarefa.getEstado().getCodigo());
                stmt.setBoolean(4, tarefa.getLixeira());
                stmt.setInt(5, tarefa.getCodigo());
                stmt.execute();
            }
        } catch (SQLException ex) {
            System.out.println("Erro: " + ex.getMessage());
            ex.printStackTrace();
            throw new Exception(ex.getMessage(), ex);
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
        List<Object> tarefas = new ArrayList<Object>();
        PreparedStatement stmt = null;
        ResultSet rs = null;
        String sql = "SELECT t.*, e.* FROM tarefa t, estado e WHERE t.codigo_estado = e.id_estado AND t.codigo_usuario = ? " +
                "AND t.lixeira = ? ORDER BY t.data_criacao_tarefa DESC, t.id_tarefa DESC";

        try {
            stmt = conn.prepareStatement(sql);
            stmt.setInt(1, idUser);
            stmt.setBoolean(2, lixeira);
            rs = stmt.executeQuery();
            while (rs.next()) {
                Tarefa tarefa = new Tarefa();
                tarefa.setCodigo(rs.getInt("id_tarefa"));
                tarefa.setTitulo(rs.getString("titulo_tarefa"));
                tarefa.setTexto(rs.getString("texto_tarefa"));
                tarefa.setDataCriacao(rs.getDate("data_criacao_tarefa"));
                tarefa.setEstado(new Estado(
                        rs.getInt("codigo_estado"),
                        rs.getString("titulo_estado"))
                );
                tarefa.setLixeira(rs.getBoolean("lixeira"));
                tarefas.add(tarefa);
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

        return tarefas;
    }

    @Override
    public Object load(int idUser, int idObject) {
        PreparedStatement stmt = null;
        ResultSet rs = null;
        Tarefa tarefa = null;
        String sql = "SELECT t.*, e.* FROM tarefa t, estado e WHERE t.codigo_estado = e.id_estado AND t.codigo_usuario = ? AND t.id_tarefa = ?";

        try {
            stmt = conn.prepareStatement(sql);
            stmt.setInt(1, idUser);
            stmt.setInt(2, idObject);
            rs = stmt.executeQuery();
            while(rs.next()) {
                tarefa = new Tarefa();
                tarefa.setCodigo(rs.getInt("id_tarefa"));
                tarefa.setTitulo(rs.getString("titulo_tarefa"));
                tarefa.setTexto(rs.getString("texto_tarefa"));
                tarefa.setDataCriacao(rs.getDate("data_criacao_tarefa"));
                tarefa.setEstado(new Estado(
                        rs.getInt("codigo_estado"),
                        rs.getString("titulo_estado"))
                );
                tarefa.setLixeira(rs.getBoolean("lixeira"));
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

        return tarefa;
    }

    @Override
    public Boolean delete(int idObject) {
        PreparedStatement stmt = null;
        String sql = "DELETE FROM tarefa WHERE id_tarefa = ?";

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

    public Boolean toggleTrash(int idObject, boolean lixeira) {
        PreparedStatement stmt = null;
        String sql = "UPDATE tarefa SET lixeira = ? WHERE id_tarefa = ?";

        try {
            stmt = conn.prepareStatement(sql);
            stmt.setBoolean(1, lixeira);
            stmt.setInt(2, idObject);
            stmt.execute();
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

    public List<Object> selectByEstado(int idUser, int estado) {
        List<Object> tarefas = new ArrayList<Object>();
        PreparedStatement stmt = null;
        ResultSet rs = null;
        String sql = "SELECT t.*, e.* FROM tarefa t, estado e WHERE t.codigo_estado = e.id_estado AND t.codigo_usuario = ? " +
                "AND t.lixeira = false AND t.codigo_estado = ? ORDER BY t.data_criacao_tarefa DESC, t.id_tarefa DESC";

        try {
            stmt = conn.prepareStatement(sql);
            stmt.setInt(1, idUser);
            stmt.setInt(2, estado);
            rs = stmt.executeQuery();
            while (rs.next()) {
                Tarefa tarefa = new Tarefa();
                tarefa.setCodigo(rs.getInt("id_tarefa"));
                tarefa.setTitulo(rs.getString("titulo_tarefa"));
                tarefa.setTexto(rs.getString("texto_tarefa"));
                tarefa.setDataCriacao(rs.getDate("data_criacao_tarefa"));
                tarefa.setEstado(new Estado(
                        rs.getInt("codigo_estado"),
                        rs.getString("titulo_estado"))
                );
                tarefa.setLixeira(rs.getBoolean("lixeira"));
                tarefas.add(tarefa);
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

        return tarefas;
    }
}
