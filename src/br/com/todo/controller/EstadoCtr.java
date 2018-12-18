package br.com.todo.controller;

import br.com.todo.dao.EstadoDAO;
import br.com.todo.model.Estado;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;

@WebServlet(name = "EstadoCtr", urlPatterns = {"/EstadoCtr"})
public class EstadoCtr extends HttpServlet {
    protected void proccessRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        response.setCharacterEncoding("UTF-8");
        PrintWriter out = response.getWriter();

        try {
            String action = request.getParameter("action");

            switch (action) {
                case "createAjaxStatus":
                    try {
                        String titulo = request.getParameter("titulo");

                        Estado estado = new Estado(null, titulo);
                        EstadoDAO dao = new EstadoDAO();
                        if (dao.save(estado)) {
                            response.setContentType("text/plain");  // Set content type of the response so that jQuery knows what it can expect.
                            response.setCharacterEncoding("UTF-8"); // You want world domination, huh?
                            Estado created = (new EstadoDAO()).lastCreated();
                            response.getWriter().write(
                                    "{\"codigo\":\""+created.getCodigo()+"\",\"titulo\":\""+created.getTitulo()+"\"}"
                            );
                        } else {
                            response.setContentType("text/plain");  // Set content type of the response so that jQuery knows what it can expect.
                            response.setCharacterEncoding("UTF-8"); // You want world domination, huh?
                            response.getWriter().write("false");
                        }
                    } catch (Exception ex) {
                        System.out.println("Erro: " + ex.getMessage());
                    }
                    break;
                case "saveStatus":
                    try {
                        Integer codigo = Integer.parseInt(request.getParameter("codigo") != null ? request.getParameter("codigo") : "0");
                        String titulo = request.getParameter("titulo");
                        String desc = request.getParameter("desc");

                        Estado estado = new Estado();
                        estado.setCodigo(codigo != 0 ? codigo : null);
                        estado.setTitulo(titulo);

                        EstadoDAO dao = new EstadoDAO();
                        if (dao.save(estado)) {
                            request.getRequestDispatcher("/EstadoCtr?action=listStatus").forward(request, response);
                        } else {
                            request.getRequestDispatcher("/EstadoCtr?action=listStatus").forward(request, response);
                        }
                    } catch (Exception ex) {
                        System.out.println("Erro: " + ex.getMessage());
                    }
                    break;
                case "deleteStatus":
                    try {
                        Integer dcodigo = Integer.parseInt(request.getParameter("dcodigo"));

                        EstadoDAO dao = new EstadoDAO();
                        if (dao.delete(dcodigo)) {
                            request.getRequestDispatcher("/EstadoCtr?action=listStatus").forward(request, response);
                        } else {
                            throw new Exception();
                            //request.getRequestDispatcher("/EstadoCtr?action=listStatus").forward(request, response);
                        }
                    } catch (Exception ex) {
                        request.setAttribute("erro", "Erro: Este estado está relacionado com uma tarefa. Edite seu estado ou exclua a tarefa antes de excluir o estado!");
                        request.getRequestDispatcher("/EstadoCtr?action=listStatus").forward(request, response);
                        System.out.println("Erro: " + ex.getMessage());
                    }
                    break;
                case "listStatus":
                    try {
                        EstadoDAO dao = new EstadoDAO();
                        request.setAttribute("estados", dao.select(0, false));
                        request.getRequestDispatcher("/dashboard/estado.jsp").forward(request, response);
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
