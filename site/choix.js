var Choix =
{
	liste: undefined,
	num2code: {},
	courant: -1,
	brancher: function()
	{
		/* À FAIRE: sur fermeture de fenêtre, enregistrer les parties dynamiques (filtre, coches, notes) dans un ou plusieurs cookies, pour pouvoir continuer la prochaine fois.
		            permettre de nommer le biscuit ("adoration du tant de telle année", garder les x derniers) */
		/* À FAIRE: ou alors, sur telecharger() comme sur noter(), modifier l'URL */
		Choix.liste = document.querySelector('#choix ul');
		Choix.liste.addEventListener('click', Choix.clic);
		document.body.addEventListener('keydown', Choix.touche);
		document.getElementById('filtre').addEventListener('keyup', Choix.saisieFiltre); /* À FAIRE: le copier-coller est-il détecté? */
		
		var i, l = Choix.liste.children;
		for(i = -1; ++i < l.length;)
			Choix.num2code[l[i].dataset.code] = i;
		
		Choix.courir(0);
	},
	saisieFiltre: function(ev)
	{
		/* À FAIRE: avec quelques ms de délai, qu'en cas de saisie rapide on ne balance pas 3 requêtes d'affilée, avec surtout le risque que le résultat de la 2ème arrive après celui de la 3ème et donc défiltre. */
		/* À FAIRE: un indicateur visuel de "en travail… terminé". */
		Choix.req = window.setTimeout(Choix.changementFiltre, 0);
	},
	changementFiltre: function()
	{
		var filtre = document.getElementById('filtre').value;
		/* À FAIRE: uniquement si changement depuis la dernière fois, une fois écartés les ensembles non significatifs (mots de moins de 3 lettres). */
		filtre = filtre.replaceAll(' ', '|');
		
		var r = new XMLHttpRequest();
		r.responseType = 'json';
		r.addEventListener('load', Choix.nouvelEnsemble);
		r.open('GET', 'filtre?q='+encodeURIComponent(filtre)); /* À FAIRE: déterminer le préfixe de façon certaine. */
		r.send();
	},
	nouvelEnsemble: function(res)
	{
		switch(res.target.readyState)
		{
			case 4:
				var filtrage = document.getElementById('choix');
				var plusProche = Choix.liste.children.length;
				res = res.target.response;
				if(res.length)
				{
					Choix.liste.querySelectorAll('.sel').forEach(function(x) { x.classList.remove('sel'); });
					filtrage.classList.add('filtre');
					for(var i = res.length; --i >= 0;)
					{
						var num;
						Choix.liste.children[num = Choix.num2code[res[i]]].classList.add('sel');
						// Si l'actuel courant finit masqué, on cherche le chant encore affiché le plus proche de lui.
						if(Math.abs(num - Choix.courant) < Math.abs(plusProche - Choix.courant))
							plusProche = num;
					}
					Choix.courir(plusProche);
				}
				else
					filtrage.classList.remove('filtre');
				break;
		}
	},
	clic: function(ev)
	{
		for(var e = ev.target; e.nodeName != 'UL'; e = e.parentElement)
			if((e.dataset && e.dataset.code) || e.id == 'telech')
			{
				/* À FAIRE: cliquer sur la CàC doit refléter la coche sur data-note (peut-être un onchange sur les CàC, pour prendre en compte tous les moyens de cocher: clic, espace si sélectionné par tabulation, etc.). */
				Choix.courir(e);
				if(e.id == 'telech')
					Choix.telecharger();
				// Pas de preventDefault: si on clique la case à cocher, ou si on veut sélectionner le titre, on laisse faire.
				break;
			}
	},
	courir: function(e, sens)
	{
		var num;
		if(typeof e == 'number')
			e = Choix.liste.children[num = e];
		else
			num = Choix.num2code[e.dataset.code];
		if(typeof sens == 'number')
		{
			var sousens = document.getElementById('choix').classList.contains('filtre');
			while((e = Choix.liste.children[num += sens]) && (sousens && !e.classList.contains('sel') && e.id != 'telech')) {}
		}
		
		if(num == Choix.courant) return;
		if(num < 0) return;
		if(num >= Choix.liste.children.length)
		{
			// Si on se trouve sur le dernier élément qui est le lien de téléchargement, en avant.
			if(Choix.courant == num - 1) Choix.telecharger();
			return;
		}
		
		var ancien = Choix.liste.children[Choix.courant];
		if(ancien)
			ancien.classList.remove('courant');
		Choix.courant = num;
		e.classList.add('courant');
		e.scrollIntoView({ block: 'center', container: 'nearest' }); // À FAIRE: Edge ne l'a supporté que très tard.
		
		/* À FAIRE: un cache de 10 chants */
		var r = new XMLHttpRequest();
		r.addEventListener('load', function(res) { if(res.target.readyState == 4) Choix.afficherChant(res.target.response); });
		r.open('GET', 'chants/'+e.dataset.code); /* À FAIRE: décoder en dur le chants/. La classe Chant devrait pouvoir nous fournir ça. */
		r.send();
	},
	noter: function(note)
	{
		var e = Choix.liste.children[Choix.courant];
		e.dataset.note = parseInt(note);
		e.querySelector('input').checked = e.dataset.note > 0;
	},
	afficherChant: function(contenu)
	{
		document.getElementById('chant').innerHTML =
			contenu
				.replaceAll('&', '&amp;')
				.replaceAll('<', '&lt;')
				.replaceAll('>', '&gt;')
				.replaceAll('\n', '<br/>\n')
				.replaceAll(/^((?:#.*\n)*)([^#<][^<]*)(?:<br\/>\n)*/g, '$1<h3>$2</h3>\n')
				.replaceAll(/(^|\n<br\/>\n|<\/h[0-9]>\n)(R\..*(?:\n[^<].*)*)/g, '$1<strong>$2</strong>')
		;
		/* À FAIRE: sélection. */
	},
	telecharger: function()
	{
		/* À FAIRE: intégrer en commentaire le filtre utilisé */
		
		var lignes = Array.from(document.querySelectorAll('#choix li :checked')).map(function(x)
		{
			var p = x.closest('li');
			return '# '+p.dataset.code+' '+p.innerText+"\n";
		});
		/* À FAIRE: trier par note décroissante, en tri stable (= si même note, conserver l'ordre alphabétique) */
		lignes = lignes.join('');
		
		/* Téléchargement en base64:
		 * https://greasyfork.org/en/scripts/411199-download-table-as-csv/code
		 * https://stackoverflow.com/questions/29280134/creating-a-greasemonkey-button-to-output-certain-data-to-a-page
		 * https://stackoverflow.com/questions/17836273/export-javascript-data-to-csv-file-without-server-interaction
		 * https://stackoverflow.com/questions/2951149/save-file-using-greasemonkey
		 * Voir aussi la possibilité (dans l'une de ces pages) de passer par un Blob collé sur window.URL.
		 */
		var formu = document.getElementsByTagName('form')[0];
		var a = document.createElement('a');
		a.href = 'data:attachment/text,'+encodeURIComponent(lignes);
		a.download = new Date().toISOString().substr(0, 10)+'.tdm';
		formu.appendChild(a);
		a.click();
		formu.removeChild(a);
		
		/* Comment faire pour avoir l'équivalent de l'attribut download?
		formu.action = 'data:attachment/text,'+encodeURIComponent("coucou\nsalut\n");
		formu.submit();
		*/
	},
	touche: function(ev)
	{
		switch(ev.key)
		{
			case 'ArrowDown':
			case 'ArrowUp':
				Choix.courir(Choix.courant, ev.key == 'ArrowDown' ? 1 : -1);
				ev.preventDefault(true);
				ev.stopPropagation();
				break;
			case '5':
			case '4':
			case '3':
			case '2':
			case '1':
			case '0':
				/* À FAIRE: espace pour 5, - pour 0 */
				if(Choix.courant < Choix.liste.children.length - 1)
				Choix.noter(ev.key);
				/* À FAIRE: ne pas passer au suivant si une option (case à cocher) "rester sur le même en notant" est cochée */
				Choix.courir(Choix.courant, 1);
				ev.preventDefault(true); // Pas de chiffre dans le champ de recherche.
				break;
		}
	}
};
