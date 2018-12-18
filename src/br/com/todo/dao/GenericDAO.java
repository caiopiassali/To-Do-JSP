package br.com.todo.dao;

import java.util.List;

public interface GenericDAO {

    public Boolean save(Object object) throws Exception;
    public List<Object> select(int idUser, boolean lixeira);
    public Object load(int idUser, int idObject);
    public Boolean delete(int idObject);

}
