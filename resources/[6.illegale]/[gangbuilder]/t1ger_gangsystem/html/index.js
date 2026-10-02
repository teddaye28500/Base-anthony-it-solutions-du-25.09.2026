window.addEventListener('message', (event) => {
    let data = event.data;
    if (data['task'] == 'showHeadbag') {
        $('.container').css({'display': 'block'});
    } else if (data['task'] == 'removeHeadbag') { 
        $('.container').css({'display': 'none'});
    }
})