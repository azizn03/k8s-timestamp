const app = require('express')();
const PORT = 80;

app.listen(
    PORT, () => {
        console.log('Its alive on http://localhost:80')
})

app.get('/timestamp', (req, res) => {
    res.status(200).send({
        message:   'Automate all the things!',
        timestamp: Date.now()

    })

});

