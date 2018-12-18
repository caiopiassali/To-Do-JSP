<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="br.com.todo.model.Tarefa" %>
<%@ page import="java.util.List" %><%--
  Created by IntelliJ IDEA.
  User: caiop
  Date: 05/11/2018
  Time: 22:11
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Dashboard: To-Do</title>

    <!-- Bootstrap core CSS -->
    <link href="../css/bootstrap.min.css" rel="stylesheet">
    <!-- Main CSS -->
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
                    <a class="nav-link js-scroll-trigger active" href="/TarefaCtr?action=listTasks" title="Dashboard">Dashboard</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link js-scroll-trigger" href="/TarefaCtr?action=lixeira" title="Lixeira">Lixeira</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link js-scroll-trigger" href="/EstadoCtr?action=listStatus" title="Estados">Estados</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link js-scroll-trigger" href="/UsuarioCtr?action=doLogout" title="Sair">Sair</a>
                </li>
            </ul>
        </div>
    </div>
</nav>

<section style="padding-top: 80px">
    <div class="container">
        <div class="row">
            <div class="col-sm-12">
                <div class="card">
                    <div class="card-body">

                        <div class="row">
                            <div class="col-sm-8">
                                <div class="row">
                                    <div class="col-sm-4 mb-1">
                                        <a href="/TarefaCtr?action=tarefa" style="color: #fff"><button class="btn btn-success btn-block" type="button">Cadastrar Tarefa</button></a>
                                    </div>
                                    <div class="col-sm-4 mb-1">
                                        <button class="btn btn-danger btn-block" type="button" data-toggle="modal" data-target="#excluirTarefa">Excluir Selecionados</button>
                                    </div>
                                </div>
                            </div>
                            <div class="col-sm-4 mb-1">
                                <select class="form-control" name="sestado" id="sestado">
                                    <option value="*">Todos os Estados</option>
                                    <c:forEach var="estado" items="${estados}">
                                        <option value="${estado.codigo}"
                                            ${codigo_estado == estado.codigo ? 'selected' : ''}>
                                                ${estado.titulo}
                                        </option>
                                    </c:forEach>
                                </select>
                            </div>
                        </div>

                        <hr>

                        <div class="row">
                            <div class="col-sm-12">
                                <table class="table table-striped table-borderless">
                                    <thead class="thead-light">
                                        <tr>
                                            <th class="align-middle">
                                                <div class="form-check">
                                                    <input class="form-check-input position-static" type="checkbox"
                                                           id="checkall" value="" title="Selecionar Todos">
                                                </div>
                                            </th>
                                            <th>Tarefa</th>
                                            <th>Estado</th>
                                            <th class="text-right">Opções</th>
                                        </tr>
                                    </thead>
                                    <tbody>

                                    <% List<Tarefa> tarefas = (List<Tarefa>) request.getAttribute("tarefas"); %>

                                    <% if (tarefas.size() == 0) { %>
                                    <tr>
                                        <td colspan="4" class="text-center">Nenhuma Tarefa Encontrada!</td>
                                    </tr>
                                    <% } for (Tarefa tarefa : tarefas) { %>
                                    <tr class="hover-cell">
                                        <td class="align-middle">
                                            <div class="form-check">
                                                <input class="form-check-input position-static" type="checkbox"
                                                       name="check<%=tarefa.getCodigo()%>" id="check<%=tarefa.getCodigo()%>" value="<%=tarefa.getCodigo()%>">
                                            </div>
                                        </td>
                                        <td data-toggle="modal" data-target="#verTarefa" class="hover-title"
                                            data-codigo="<%=tarefa.getCodigo()%>" data-titulo="<%=tarefa.getTitulo()%>"
                                            data-texto="<%=tarefa.getTexto()%>" data-codigo-estado="<%=tarefa.getEstado().getCodigo()%>"
                                            data-criacao="<%=tarefa.getDataCriacao()%>">
                                            <span>
                                                <h5 title="Gerenciar Tarefa"><%=tarefa.getTitulo()%></h5>
                                            </span>
                                            <span class="d-inline-block"><%=tarefa.getTexto()%></span>
                                        </td>
                                        <td class="align-middle hover-title" data-toggle="modal" data-target="#verTarefa"
                                            data-codigo="<%=tarefa.getCodigo()%>" data-titulo="<%=tarefa.getTitulo()%>"
                                            data-texto="<%=tarefa.getTexto()%>" data-codigo-estado="<%=tarefa.getEstado().getCodigo()%>"
                                            data-criacao="<%=tarefa.getDataCriacao()%>">
                                            <%=tarefa.getEstado().getTitulo()%>
                                        </td>
                                        <td class="text-right align-middle">
                                            <a href="#" data-toggle="modal" data-target="#verTarefa"
                                               data-codigo="<%=tarefa.getCodigo()%>" data-titulo="<%=tarefa.getTitulo()%>"
                                               data-texto="<%=tarefa.getTexto()%>" data-codigo-estado="<%=tarefa.getEstado().getCodigo()%>"
                                               data-criacao="<%=tarefa.getDataCriacao()%>">
                                                &#x270E;
                                            </a>
                                            <a href="#" data-toggle="modal" data-target="#excluirTarefa" data-codigo="<%=tarefa.getCodigo()%>">
                                                &#128465;
                                            </a>
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
<div class="modal fade" id="verTarefa" tabindex="-1" role="dialog">
    <div class="modal-dialog modal-dialog-centered" role="document">
        <form style="width: 100%" action="/TarefaCtr?action=updateTask" method="post">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title">Visualizar Tarefa</h5>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body">
                    <input type="hidden" name="codigo" id="codigo">
                    <div class="row">
                        <div class="col-sm-12">
                            <p name="dataCriacao"></p>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-sm-8">
                            <div class="form-group">
                                <label for="titulo">Título:</label>
                                <input type="text" class="form-control" name="titulo" id="titulo">
                            </div>
                        </div>
                        <div class="col-sm-4 text-right">
                            <div class="form-group">
                                <label for="estado">Estado:</label>
                                <select class="form-control" name="estado" id="estado">
                                    <c:forEach var="estado" items="${estados}">
                                        <option value="${estado.codigo}">
                                                ${estado.titulo}
                                        </option>
                                    </c:forEach>
                                </select>
                            </div>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-sm-12">
                            <div class="form-group">
                                <label for="texto">Texto:</label>
                                <textarea class="form-control" name="texto" id="texto" cols="30" rows="5"></textarea>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="modal-footer">
                    <div class="col-6">
                        <button type="submit" class="btn btn-success">Salvar</button>
                    </div>
                    <div class="col-6 text-right">
                        <button type="button" class="btn btn-danger" data-toggle="modal" data-target="#excluirTarefa">Excluir</button>
                    </div>
                </div>
            </div>
        </form>
    </div>
</div>

<!-- Modal -->
<div class="modal fade" id="excluirTarefa" tabindex="-1" role="dialog">
    <form name="deleteTask" action="/TarefaCtr?action=deleteTask" method="post">
        <div class="modal-dialog modal-dialog-centered" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title">Excluir Tarefa</h5>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body text-center">
                    <input type="hidden" name="dcodigo" id="dcodigo">
                    <p>Tem certeza que quer excluir esta(s) tarefa(s)?</p>
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

<!-- Modal -->
<div class="modal fade" id="errorModal" tabindex="-1" role="dialog">
    <div class="modal-dialog modal-dialog-centered" role="document">
        <div class="modal-content bg-danger text-white">
            <div class="modal-header">
                <h5 class="modal-title">Erro</h5>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <div class="modal-body text-center">
                <p>Selecione ao menos uma Tarefa para excluir!</p>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-outline-light" data-dismiss="modal">OK</button>
            </div>
        </div>
    </div>
</div>

<!-- Bootstrap core JavaScript -->
<script src="../js/jquery-3.3.1.min.js"></script>
<script src="../js/popper.min.js"></script>
<script src="../js/bootstrap.min.js"></script>

<script !src="">
    $('select[name=sestado]').on('change', function () {
       var estado = this.value;
       if (estado === '*')
            window.location.href = "/TarefaCtr?action=listTasks";
       else
           window.location.href = "/TarefaCtr?action=listTasks&codigo_estado=" + estado;
    });

    $('#verTarefa').on('show.bs.modal', function (event) {
        var button = $(event.relatedTarget); // Button that triggered the modal
        var recipient = button.data(); // Extract info from data-* attributes
        // If necessary, you could initiate an AJAX request here (and then do the updating in a callback).
        // Update the modal's content. We'll use jQuery here, but you could use a data binding library or other methods instead.
        var modal = $(this);
        modal.find('.modal-body input[name=codigo]').val(recipient.codigo);
        modal.find('.modal-body p[name=dataCriacao]').text("Criado em: " + new Date(recipient.criacao).toLocaleDateString('pt-BR', { timeZone: 'UTC' }) );
        modal.find('.modal-body input[name=titulo]').val(recipient.titulo);
        modal.find('.modal-body select[name=estado]').val(recipient.codigoEstado);
        modal.find('.modal-body textarea').val(recipient.texto);
        modal.find('.modal-footer button.btn.btn-danger').attr("data-codigo", recipient.codigo);
    });

    $('#excluirTarefa').on('show.bs.modal', function (event) {
        var button = $(event.relatedTarget); // Button that triggered the modal
        var recipient = button.data(); // Extract info from data-* attributes
        // If necessary, you could initiate an AJAX request here (and then do the updating in a callback).
        // Update the modal's content. We'll use jQuery here, but you could use a data binding library or other methods instead.
        var modal = $(this);
        modal.find('.modal-body input[name=dcodigo]').val(recipient.codigo);
    });

    $("form[name=deleteTask]").on('submit', function (e) {
        e.preventDefault();
        var dcodigos = [];
        var form = $(this);
        var dcodigo = form.find('input[name=dcodigo]').val();
        if (dcodigo === "") {
            //$("input.form-check-input").each(function() {
            $("input.form-check-input[name^='check']").each(function () {
                if ($(this).is(':checked'))
                    dcodigos.push(this.value);
            });
            form.find('input[name=dcodigo]').val(dcodigos.toString());
        }
        if (dcodigo === "" && dcodigos.length === 0) {
            $("#excluirTarefa").modal('toggle');
            $("#errorModal").modal('toggle');
            //alert("Nenhuma Tarefa Selecionada!");
        } else {
            this.submit();
        }
    });

    $("#checkall").on('click', function (e) {
        var checked = $(this).is(':checked');
        $("input[type=checkbox]").each(function () {
            $(this).attr('checked', checked ? true : false);
        });
    });
</script>

</body>
</html>
