package com.prms.client.flex.module
{
    import com.prms.client.flex.model.AccountModelLocator;

    public interface ICairngormModule
    {
        function set model(model:AccountModelLocator):void;
        function get model():AccountModelLocator;
    }
}

