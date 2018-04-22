// node.js script voor instellen stand ventilatie mbv mqtt
// https://blog.risingstack.com/getting-started-with-nodejs-and-mqtt/

/*
als daemon uitvoeren met deze commando's
user@host:~/brink $ node setvent_1.js </dev/null >/dev/null 2>&1 & disown
*/

const mqtt = require('/usr/lib/node_modules/mqtt')
const client = mqtt.connect('mqtt://192.168.0.92:1883')
const { exec } = require('child_process')

client.on('connect', () => {
	client.subscribe('renovent')
})

client.on('message', (topic, message) => {
	console.log('received message %s %s', topic, message)
	switch (topic) {
		case 'renovent':
			return handleRenoventRequest(message)
	}
})

function handleRenoventRequest (message) {
	console.log('ventilatie %s', message)
	exec('bash ventctl.sh ' + message, (err, stdout, stderr) => {
		if (err) {
			// node couldn't execute the command
			return;
		}

		// the *entire* stdout and stderr (buffered)
		console.log(`stdout: ${stdout}`);
		console.log(`stderr: ${stderr}`);
	});
}

//https://stackoverflow.com/questions/14031763/doing-a-cleanup-action-just-before-node-js-exits/14032965#14032965
process.stdin.resume();//so the program will not close instantly

function exitHandler(options, err) {
    if (options.cleanup) console.log('clean');
    if (err) console.log(err.stack);
    if (options.exit) process.exit();
}

//do something when app is closing
process.on('exit', exitHandler.bind(null,{cleanup:true}));

//catches ctrl+c event
process.on('SIGINT', exitHandler.bind(null, {exit:true}));

// catches "kill pid" (for example: nodemon restart)
process.on('SIGUSR1', exitHandler.bind(null, {exit:true}));
process.on('SIGUSR2', exitHandler.bind(null, {exit:true}));

//catches uncaught exceptions
process.on('uncaughtException', exitHandler.bind(null, {exit:true}));
