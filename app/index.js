const app = require('express')();
const PORT = 8080;

app.listen(
    PORT, () => {
        console.log('Its alive on http://localhost:8080')
})

app.get('/timestamp', (req, res) => {
    res.status(200).send({
        message:   'Automate all the things!',
        timestamp: Date.now()

    })

});

