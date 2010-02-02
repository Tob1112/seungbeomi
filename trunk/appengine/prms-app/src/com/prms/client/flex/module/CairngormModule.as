package com.prms.client.flex.module
{
    import com.prms.client.flex.model.AccountModelLocator;

    import mx.modules.Module;

    public class CairngormModule extends Module implements ICairngormModule
    {
        [Bindable]
        private var _model:AccountModelLocator;
        public function set model(model:AccountModelLocator):void
        {
            _model = model;
        }
        public function get model():AccountModelLocator
        {
            return _model;
        }
    }
}

