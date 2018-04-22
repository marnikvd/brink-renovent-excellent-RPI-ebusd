# brink renovent excellent + Raspberry Pi + ebusd</br>
<p>The <a href="https://www.thermad-brink.be/nl-BE/renovent-excellent/9/25/">heat recovery appliance</a> needs to receive a send and keep alive command from the master on the ebus link in order to maintain its ventilation flow rate.  The script <ins>ventctl.sh</ins> can be used to do this from the command line.<br />
The node.js script <ins>setvent_1.js</ins> exposes this functionality to mqtt.</p>
<p>sources
<ul>
	<li><a href="https://forum.fhem.de/index.php/topic,84636.0.html">Raspberry pi extension board</a></li>
	<li>https://github.com/john30/ebusd</li>
	<li>https://github.com/eBUS/ttyebus</li>
	<li>https://github.com/timd93/ebusd-config-brink-renovent-excellent-300</li>
	<li>mosquitto</li>
	<li>node.js</li>
	<li><a href="https://play.google.com/store/apps/details?id=net.routix.mqttdash&hl=nl">android mqtt dash</a>
	<ul>
		<li>button 1 (handled by setvent_1.js)
		<ul>
			<li>Topic = renovent</li>
			<li>Options =
			<ul>
				<li>Payload = Minimal</li>
				<li>Payload = Reduced</li>
				<li>Payload = Normal</li>
				<li>Payload = Intensive</li>
			</ul></li>    
		</ul></li>
		<li>button 2 (<a href="https://github.com/john30/ebusd/wiki/3.3.-MQTT-client">handled by ebusd</a>)
		<ul>
			<li>Topic = ebusd/kwl/FanSpeed</li>
			<li>JSON path = $.0.value</li>
		</ul></li>
	</ul></li>
</ul></p>
