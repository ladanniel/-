$(document).ready(function() {
    $("#form").steps({
        bodyTag: "fieldset",
        onStepChanging: function(event, currentIndex, newIndex) {
            if (currentIndex > newIndex) {
                return true
            }
            if (newIndex === 3 && Number($("#age").val()) < 18) {
                return false
            }
            var form = $(this);
            if (currentIndex < newIndex) {
                $(".body:eq(" + newIndex + ") label.error", form).remove();
                $(".body:eq(" + newIndex + ") .error", form).removeClass("error")
            }
            form.validate().settings.ignore = ":disabled,:hidden";
            return form.valid()
        },
        onStepChanged: function(event, currentIndex, priorIndex) {
            if (currentIndex === 2 && Number($("#age").val()) >= 18) {
                $(this).steps("next")
            }
            if (currentIndex === 2 && priorIndex === 3) {
                $(this).steps("previous")
            }
        },
        onFinishing: function(event, currentIndex) {
            var form = $(this);
            form.validate().settings.ignore = ":disabled";
            return form.valid()
        },
        onFinished: function(event, currentIndex) {
            var form = $(this);
            form.submit()
        }
    }).validate({
        errorPlacement: function(error, element) {
            element.before(error)
        },
        rules: {
            confirm: {
                equalTo: "#password"
            }
        }
    })
});