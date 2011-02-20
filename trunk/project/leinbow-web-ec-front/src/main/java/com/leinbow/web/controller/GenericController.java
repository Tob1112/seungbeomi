package com.leinbow.web.controller;

import java.io.Serializable;
import java.util.List;

import org.springframework.web.bind.annotation.RequestMapping;

import com.leinbow.service.GenericService;

/**
 * @author JungJoo Seo
 * GenericControllerは必要に応じて使用する。
 * 必ず使う必要はない。
 * 基本的なCRUD処理はGenericControllerを承継して処理し、それ以外の処理がCustomしたControllerを使うこと。
 *
 * @param <T>
 * @param <PK>
 * @param <S>
 */
public abstract class GenericController<T, PK extends Serializable, S extends GenericService<T, PK>> {
    S service;

    @RequestMapping("/add")
    public void add(T entity) {
        service.save(entity); // service.saveはupdateとinsertを全部対応する。
    }

    @RequestMapping("/update")
    public void update(T entity) {
        service.save(entity); // service.saveはupdateとinsertを全部対応する。
    }

    @RequestMapping("/view")
    public T view(PK id) {
        return service.get(id);
    }

    @RequestMapping("/delete")
    public void delete(PK id) {
        service.remove(id);
    }

    @RequestMapping("/list")
    public List<T> list() {
        return service.getAll();
    }

}
