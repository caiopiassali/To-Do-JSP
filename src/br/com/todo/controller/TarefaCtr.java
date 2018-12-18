package br.com.todo.controller;

import br.com.todo.dao.EstadoDAO;
import br.com.todo.dao.GenericDAO;
import br.com.todo.dao.TarefaDAO;
import br.com.todo.model.Estado;
import br.com.todo.model.Tarefa;
import br.com.todo.model.Usuario;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.io.PrintWriter;

@WebServlet(name = "TarefaCtr", urlPatterns = {"/TarefaCtr"})
public class TarefaCtr extends HttpServlet {
    protected void proccessRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        response.setCharacterEncoding("UTF-8");
        PrintWriter out = response.getWriter();

        try {
            EstadoDAO edao = new EstadoDAO();

            HttpSession session = request.getSession();
            Usuario usuario = (Usuario) session.getAttribute("usuario");

            if (usuario == null) {
                response.sendRedirect("entrar.jsp");
                return;
            }

            String action = request.getParameter("action");
            Integer userId = usuario.getCodigo();

            switch (action) {
                case "tarefa":
                    request.setAttribute("estados", edao.select(0, false));
                    request.getRequestDispatcher("/dashboard/tarefa.jsp").forward(request, response);
                    break;
                case "lixeira":
                    try {
                        TarefaDAO dao = new TarefaDAO();
                        request.setAttribute("tarefas", dao.select(userId, true));
                        request.getRequestDispatcher("/dashboard/lixeira.jsp").forward(request, response);
                    } catch (Exception ex) {
                        System.out.println("Erro: " + ex.getMessage());
                    }
                    break;
                case "listTasks":
                    try {
                        Integer estado = null;
                        if (request.getParameter("codigo_estado") != null && request.getParameter("codigo_estado") != "") {
                            estado = Integer.parseInt(request.getParameter("codigo_estado"));
                        }

                        TarefaDAO dao = new TarefaDAO();
                        if (estado != null) {
                            request.setAttribute("codigo_estado", estado);
                            request.setAttribute("tarefas", dao.selectByEstado(userId, estado));
                        } else {
                            request.setAttribute("tarefas", dao.select(userId, false));
                        }
                        request.setAttribute("estados", edao.select(0, false));
                        request.getRequestDispatcher("/dashboard/dashboard.jsp").forward(request, response);
                    } catch (Exception ex) {
                        System.out.println("Erro: " + ex.getMessage());
                    }
                    break;
                case "createTask":
                    try {
                        String titulo = request.getParameter("titulo");
                        String texto = request.getParameter("texto");
                        Integer estado = Integer.parseInt(request.getParameter("estado"));

                        Tarefa tarefa = new Tarefa();
                        tarefa.setTitulo(titulo);
                        tarefa.setTexto(texto);
                        tarefa.setEstado(new Estado(estado, null));
                        tarefa.setUsuario(new Usuario(userId));
                        tarefa.setLixeira(false);

                        GenericDAO dao = new TarefaDAO();
                        if (dao.save(tarefa)) {
                            request.getRequestDispatcher("/TarefaCtr?action=listTasks").forward(request, response);
                        } else {
                            request.getRequestDispatcher("/TarefaCtr?action=listTasks").forward(request, response);
                        }
                    } catch (Exception ex) {
                        System.out.println("Erro: " + ex.getMessage());
                        request.setAttribute("erro", ex.getMessage());
                        request.getRequestDispatcher("/TarefaCtr?action=tarefa").forward(request, response);
                    }
                    break;
                case "updateTask":
                    try {
                        Integer codigo = Integer.parseInt(request.getParameter("codigo"));
                        String titulo = request.getParameter("titulo");
                        Integer estado = Integer.parseInt(request.getParameter("estado"));
                        String texto = request.getParameter("texto");

                        Tarefa tarefa = new Tarefa();
                        tarefa.setCodigo(codigo);
                        tarefa.setTitulo(titulo);
                        tarefa.setTexto(texto);
                        tarefa.setEstado(new Estado(estado, null));
                        tarefa.setLixeira(false);

                        GenericDAO dao = new TarefaDAO();
                        if (dao.save(tarefa)) {
                            request.getRequestDispatcher("/TarefaCtr?action=listTasks").forward(request, response);
                        } else {
                            request.getRequestDispatcher("/TarefaCtr?action=listTasks").forward(request, response);
                        }
                    } catch (Exception ex) {
                        System.out.println("Erro: " + ex.getMessage());
                    }
                    break;
                case "deleteTask":
                    try {
                        String dcodigo = request.getParameter("dcodigo");
                        String[] codigos = dcodigo.split(",");

                        for (String codigo:codigos) {
                            Integer cdg = Integer.parseInt(codigo);

                            TarefaDAO dao = new TarefaDAO();
                            dao.toggleTrash(cdg, true);
                        }

                        request.getRequestDispatcher("/TarefaCtr?action=listTasks").forward(request, response);
                    } catch (Exception ex) {
                        request.getRequestDispatcher("/TarefaCtr?action=listTasks").forward(request, response);
                        System.out.println("Erro: " + ex.getMessage());
                    }
                    break;
                case "restoreTask":
                    try {
                        String rcodigo = request.getParameter("rcodigo");
                        String[] codigos = rcodigo.split(",");

                        for (String codigo:codigos) {
                            Integer cdg = Integer.parseInt(codigo);

                            TarefaDAO dao = new TarefaDAO();
                            dao.toggleTrash(cdg, false);
                        }

                        request.getRequestDispatcher("/TarefaCtr?action=lixeira").forward(request, response);
                    } catch (Exception ex) {
                        System.out.println("Erro: " + ex.getMessage());
                    }
                    break;
                case "dropTask":
                    try {
                        String dcodigo = request.getParameter("dcodigo");
                        String[] codigos = dcodigo.split(",");

                        for (String codigo:codigos) {
                            Integer cdg = Integer.parseInt(codigo);

                            TarefaDAO dao = new TarefaDAO();
                            dao.delete(cdg);
                        }

                        request.getRequestDispatcher("/TarefaCtr?action=lixeira").forward(request, response);
                    } catch (Exception ex) {
                        System.out.println("Erro: " + ex.getMessage());
                    }
                    break;
                default:
                    break;
            }
        } catch (Exception ex) {
            System.out.println("Erro: " + ex.getMessage());
        }
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        proccessRequest(request, response);
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        proccessRequest(request, response);
    }
}
