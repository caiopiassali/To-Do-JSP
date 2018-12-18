<%@ page import="br.com.todo.model.Estado" %>
<%@ page import="java.util.List" %><%--
  Created by IntelliJ IDEA.
  User: caiop
  Date: 08/11/2018
  Time: 14:11
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Estados: To-Do</title>

    <!-- Bootstrap core CSS -->
    <link href="../css/bootstrap.min.css" rel="stylesheet">

    <link rel="stylesheet" href="../css/main.css">
</head>
<body>

<!-- Navigation -->
<nav class="navbar navbar-expand-lg navbar-dark bg-dark fixed-top" id="mainNav">
    <div class="container">
        <a class="navbar-brand js-scroll-trigger" href="/" title="Dashboard">To-Do</a>
        <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarResponsive" aria-controls="navbarResponsive" aria-expanded="false" aria-label="Toggle navigation">
            <span class="navbar-toggler-icon"></span>
        </button>
        <div class="collapse navbar-collapse" id="navbarResponsive">
            <ul class="navbar-nav ml-auto">
                <li class="nav-item">
                    <a class="nav-link js-scroll-trigger" href="/TarefaCtr?action=listTasks" title="Dashboard">Dashboard</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link js-scroll-trigger" href="/TarefaCtr?action=lixeira" title="Lixeira">Lixeira</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link js-scroll-trigger active" href="/EstadoCtr?action=listStatus" title="Estados">Estados</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link js-scroll-trigger" href="/UsuarioCtr?action=doLogout" title="Sair">Sair</a>
                </li>
            </ul>
        </div>
    </div>
</nav>

<section style="padding-top: 80px" class="mb-5">
    <div class="container">
        <div class="row">
            <div class="col-sm-6 offset-3">
                <div class="card">
                    <div class="card-body">
                        <h3 class="text-center">Cadastrar Estado</h3>
                        <form action="/EstadoCtr?action=saveStatus" method="post">
                            <% if (request.getAttribute("erro") != null) { %>
                            <div class="form-group">
                                <div class="alert alert-danger alert-dismissible fade show" role="alert">
                                    <%=request.getAttribute("erro")%>
                                    <button type="button" class="close" data-dismiss="alert" aria-label="Close">
                                        <span aria-hidden="true">&times;</span>
                                    </button>
                                </div>
                            </div>
                            <% } %>
                            <div class="form-group">
                                <input class="form-control form-control-lg" type="text" name="titulo" id="titulo" placeholder="Título" required>
                            </div>
                            <div class="form-group">
                                <input type="hidden" name="codigo" id="codigo" value="0">
                                <div class="row">
                                    <div class="col-6">
                                        <input class="btn btn-success btn-block" type="submit" value="Cadastrar">
                                    </div>
                                    <div class="col-6">
                                        <input class="btn btn-secondary btn-block" type="reset" value="Cancelar">
                                    </div>
                                </div>
                            </div>
                        </form>
                        <div class="row">
                            <div class="col-sm-12 mt-3">
                                <h5 class="text-center">Estados</h5>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-sm-12">
                                <table class="table table-striped table-borderless">
                                    <thead class="thead-light">
                                    <tr>
                                        <th>Estado</th>
                                        <th class="text-right">Opções</th>
                                    </tr>
                                    </thead>
                                    <tbody>

                                    <% List<Estado> estados = (List<Estado>) request.getAttribute("estados");
                                        for (Estado estado : estados) { %>
                                    <tr>
                                        <td>
                                            <span>
                                                <%=estado.getTitulo()%>
                                            </span>
                                        </td>
                                        <td class="text-right align-middle">
                                            <% if (estado.getCodigo() > 4) { %>
                                                <a href="#" name="editStatus" title="Editar Estado"
                                                   data-codigo="<%=estado.getCodigo()%>"
                                                   data-titulo="<%=estado.getTitulo()%>">
                                                    &#x270E;
                                                </a>

                                                <a href="#" data-toggle="modal" data-target="#excluirEstado"
                                                   title="Excluir Estado" data-codigo="<%=estado.getCodigo()%>">
                                                    &#128465;
                                                </a>
                                            <% } %>
                                        </td>
                                    </tr>
                                    <% } %>

                                    </tbody>
                                </table>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</section>

<!-- Modal -->
<div class="modal fade" id="excluirEstado" tabindex="-1" role="dialog">
    <form name="deleteTask" action="/EstadoCtr?action=deleteStatus" method="post">
        <div class="modal-dialog modal-dialog-centered" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title">Excluir Estado</h5>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body">
                    <input type="hidden" name="dcodigo" id="dcodigo">
                    <p>Tem certeza que quer excluir "Permanentemente" este Estado?</p>
                </div>
                <div class="modal-footer">
                    <div class="col-6">
                        <button type="submit" class="btn btn-danger">Excluir</button>
                    </div>
                    <div class="col-6 text-right">
                        <button type="button" class="btn btn-secondary" data-dismiss="modal">Cancelar</button>
                    </div>
                </div>
            </div>
        </div>
    </form>
</div>

<!-- Bootstrap core JavaScript -->
<script src="../js/jquery-3.3.1.min.js"></script>
<script src="../js/popper.min.js"></script>
<script src="../js/bootstrap.min.js"></script>

<script !src="">
    $("a[name=editStatus]").on('click', function () {
        var codigo = $(this).attr('data-codigo');
        var titulo = $(this).attr('data-titulo');

        $("div.card-body > h3").text("Editar Estado");
        $("form input[name=codigo]").val(codigo);
        $("form input[name=titulo]").val(titulo);
        $("form input[type=submit]").val("Salvar");
        $("form input[name=titulo]").focus();
    });

    $("form").on('reset', function (e) {
        if ($("div.card-body > h3").text() != "Editar Estado") {
            e.preventDefault();
            window.location.href = "/TarefaCtr?action=listTasks";
        }
        $("div.card-body > h3").text("Cadastrar Estado");
       $(this).find("input[name=codigo]").val(0);
       $(this).find("input[type=submit]").val("Cadastrar");
    });

    $('#excluirEstado').on('show.bs.modal', function (event) {
        var button = $(event.relatedTarget); // Button that triggered the modal
        var recipient = button.data(); // Extract info from data-* attributes
        // If necessary, you could initiate an AJAX request here (and then do the updating in a callback).
        // Update the modal's content. We'll use jQuery here, but you could use a data binding library or other methods instead.
        var modal = $(this);
        modal.find('.modal-body input[name=dcodigo]').val(recipient.codigo);
    });
</script>

</body>
</html>
