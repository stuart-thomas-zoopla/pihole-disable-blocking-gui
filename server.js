const express = require('express');
const cors = require('cors');
const { exec } = require('child_process');
const dotenv = require('dotenv');
const app = express();

app.use(cors());
dotenv.config({ path: __dirname + '/.env' });

const seconds = process.env.SECONDS;
const ip_array = process.env.IP_CSV.split(',');
const disableApi = `admin/api.php?disable=${seconds}&auth=${process.env.AUTH_TOKEN}`;

app.use(express.static(__dirname));

app.get('/seconds', (req, res) => {
    res.json({ seconds });
});

app.get('/disable', (req, res) => {
    ip_array.forEach((ip, index) => {
        const command = `curl -s "http://${ip}/${disableApi}"`;

        exec(command, (error, stdout, stderr) => {
            if (error) {
                console.error(`Error executing command for IP ${ip}: ${error}`);
            } else {
                console.log(`Success for IP ${ip}: ${stdout}`);
            }
        });

        res.json({ status: 'success', results });
    });
});

const port = 3000;
app.listen(port, () => {
    console.log(`Server running at http://localhost:${port}`);
});