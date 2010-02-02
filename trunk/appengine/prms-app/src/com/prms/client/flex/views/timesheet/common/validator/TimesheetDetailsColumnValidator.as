package com.prms.client.flex.views.timesheet.common.validator
{
    import mx.validators.Validator;

    public class TimesheetDetailsColumnValidator extends Validator
    {
        public function TimesheetDetailsColumnValidator()
        {
            super();
        }

        override protected function doValidation(value:Object):Array{
            var results:Array = super.doValidation(value);
            if(results.length != 0){
                return results;
            }
            return results;
        }
    }
}

