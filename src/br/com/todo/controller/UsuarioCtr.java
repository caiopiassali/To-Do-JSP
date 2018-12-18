package br.com.todo.controller;

import br.com.todo.dao.UsuarioDAO;
import br.com.todo.model.Usuario;
import br.com.todo.utils.Hash;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.Date;

@WebServlet(name = "UsuarioCtr", urlPatterns = {"/UsuarioCtr"})
public class UsuarioCtr extends HttpServlet {
    protected void proccessRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();

        try {
            String action = request.getParameter("action");
            String nome = request.getParameter("nome");
            String email = request.getParameter("email");
            String user = request.getParameter("usuario");
            String password = request.getParameter("senha");

            Usuario usuario = new Usuario();

            switch (action) {
                case "doSignIn":
                    usuario.setLogin(user);
                    usuario.setSenha(Hash.md5(password));

                    try {
                        UsuarioDAO dao = new UsuarioDAO();
                        Usuario usu = dao.signIn(usuario);
                        if (usu != null) {
                            HttpSession session = request.getSession();
                            session.setAttribute("usuario", usu);
                            request.getRequestDispatcher("/TarefaCtr?action=listTasks").forward(request, response);
                            //response.sendRedirect("dashboard/dashboard.jsp");
                        } else {
                            request.setAttribute("mensagem", "Usuário ou Senha inválidos!");
                            request.getRequestDispatcher("entrar.jsp").forward(request, response);
                            request.setAttribute("mensagem", null);
                        }
                    } catch (Exception ex) {
                        throw new Exception(ex);
                        //System.out.println("Erro: " + ex.getMessage());
                    }
                    break;
                case "doSignUp":
                    usuario.setNome(nome);
                    usuario.setEmail(email);
                    usuario.setLogin(user);
                    usuario.setSenha(Hash.md5(password));

                    try {
                        UsuarioDAO dao = new UsuarioDAO();
                        if (dao.signUp(usuario)) {
                            response.sendRedirect("entrar.jsp");
                        } else {
                            response.sendRedirect("index.jsp");
                        }
                    } catch (Exception ex) {
                        System.out.println("Erro: " + ex.getMessage());
                    }
                    break;
                case "doLogout":
                    HttpSession session = request.getSession();
                    session.invalidate();
                    response.sendRedirect("dashboard/sair.jsp");
                default:
                    break;
            }
        } catch (Exception ex) {
            out.println("Erro: " + ex.getMessage());
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
