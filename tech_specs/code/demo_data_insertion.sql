-- ####---  PIZZA  ---#### --

INSERT INTO pizza (
	nom,
	description,
	prix
) VALUES (
	'The pizza',
	'The best description ever...',
	32.00
),
(
	'Expensive pizza',
	'A description for the expensive pizza...',
	352.00
);

-- Image Pizza --

DO $$
DECLARE pizza_t RECORD;
BEGIN
FOR pizza_t IN SELECT id FROM pizza
LOOP
	INSERT INTO image_pizza (
		url,
		pizza_id
	) VALUES (
		'oc_pizza.com/images/pizza_' || pizza_t.id,
		pizza_t.id
	);
END LOOP;
END $$ LANGUAGE plpgsql;

-- Aide memoire --

DO $$
DECLARE pizza_t RECORD;
BEGIN
FOR pizza_t IN SELECT id FROM pizza
LOOP
	INSERT INTO aide_memoire (
		pizza_id,
		nom,
		contenu
	) VALUES (
		pizza_t.id,
		'Aide-memoire-' || pizza_t.id,
		'Verrrryyy Long description Verrrryyy Long description...' || pizza_t.id
	);
END LOOP;
END $$ LANGUAGE plpgsql;

-- #####  Ingredient ##### --

INSERT INTO ingredient (
	nom,
	description
) VALUES
	('farine','just flourrrr....'),
	('sel','just salt....');

-- Ingredient Pizza Association --

INSERT INTO ingredient_pizza_association (
    pizza_id,
    ingredient_id
) VALUES
    (1, 2 ),
    (2, 1 );

-- ##### Adresse ##### --

INSERT INTO adresse (
	code_postal,
	ville,
	rue,
	num_batiment,
	pays,
	teritoire
) VALUES
	('H5J 1A3', 'Montréal', '54 RUE other DB', 353, 'CANADA', 'QUEBEC'),
	('C5J 9Y3', 'Longueil', '45 RUELLE TEST DB', 353, 'CANADA', 'QUEBEC'),
	('G5J 2Y3', 'Sherbrooke', '434 RUE  DB', 353, 'CANADA', 'QUEBEC'),
	('N5J 9Y3', 'drummondville', '84 RUE Basededonne DB', 353, 'CANADA', 'QUEBEC'),
	('G5J 1B3', 'Chicoutimi', '454 RUE TEST DB', 353, 'CANADA', 'QUEBEC'),
	('?5J HY3', 'Boucherville', '454 RUE TEST DB', 353, 'CANADA', 'QUEBEC'),
	('G5J 1Y3', 'Brossard', '1054 RUELLe DATABASE DB', 353, 'CANADA', 'QUEBEC'),
	('G9J 1P3', 'Québec', '454 RUE TEST DB', 353, 'CANADA', 'QUEBEC'),
	('G8J 1JH', 'Ville', '85 RUELLE TOST BD', 53, 'CANADA', 'ONTARIO');

-- Pizzeria --

INSERT INTO pizzeria (
    adresse_id,
    taux_tax
) VALUES
    (1, 15.00),
    (2, 15.00);

-- #### Jour Ouvrable ### --

INSERT INTO jour_ouvrable(
    jour,
    heure_ouverture,
    heure_fermeture
) VALUES
    ('Lundi', '08:00', '16:30'),
    ('Lundi', '07:00', '17:00'),
    ('Mardi', '07:00', '17:00'),
    ('Mercredi', '07:00', '17:00'),
    ('Jeudi', '07:00', '17:00'),
    ('Samedi', '10:00', '15:00'),
    ('Vendredi', '08:00', '16:30');


-- ### Pizzeria Jour Ouvrable ### --

INSERT INTO pizzeria_jour_ouvrable (
    jour_ouvrable_id,
    pizzeria_id
) VALUES
    (1, 1),
    (3, 1),
    (4, 1),
    (5, 1),
    (6, 1),
    (7, 1),
    (2, 2),
    (3, 2),
    (4, 2),
    (5, 2),
    (6, 2),
    (7, 2);

-- ##### Utilisateur #### --

INSERT INTO utilisateur (
    adresse_id,
    numero_telephone,
    email,
    nom,
    pizzeria_id,
    prenom
) VALUES
( 1, 5817008257, 'database@ocpizza.shop', 'Musk', 2, 'Elun'),
( 2, 5817008257, 'test@ocpizza.shop', 'Musk', 2, 'Elun'),
( 3, 4587208257, 'nik@ocpizza.shop', 'Tesla', 1, 'Nikola'),
( 4, 5817008257, 'ariel@ocpizza.shop', 'Musk', 1, 'Elun'),
( 5, 5817008257, 'naruto@ocpizza.shop', 'Einstein', 2, 'Albert'),
( 6, 5817008257, 'onepice@ocpizza.shop', 'Berete', 2, 'Sita'),
( 7, 5817008257, 'attack@ocpizza.shop', 'Musk', 1, 'Elun'),
( 8, 5817008257, 'on_titan@ocpizza.shop', 'Einstein', 2, 'Albert');

-- Pizzaiolo --

INSERT INTO pizzaiolo (
    utilisateur_id,
    total_commande_preparee
) VALUES (
    1,
    46
);

INSERT INTO pizzaiolo (
  utilisateur_id,
  total_commande_preparee
) VALUES (
  8,
  13
);

-- Livreur --

INSERT INTO livreur (
    utilisateur_id,
    total_livraison_effectuee,
    url_photo_permis_conduire
) VALUES (
    5,
    8,
    'photo.url.permis@oc_pizza.com'
);
INSERT INTO livreur (
    utilisateur_id,
    total_livraison_effectuee,
    url_photo_permis_conduire
) VALUES (
    3,
    31,
    'static.files.permis@oc_pizza.com'
);

-- Client --

INSERT INTO client (
    utilisateur_id
) VALUES (4);

INSERT INTO client (
    utilisateur_id
) VALUES (7);

-- ### Carte Credit ### --

INSERT INTO carte_credit (
    numero,
    annee_expiration,
    mois_expiration,
    client_id,
    nom_proprietaire
) VALUES
    (4042546423356547, 2030, 02, 4, 'Steeve Jobs'),
    (4042777773356547, 2026, 08, 7, 'Steeve Voz'),
    (4042555553356547, 2030, 02, 4, 'Steeve Jobs');

-- Responsable --

INSERT INTO responsable (
    utilisateur_id
) VALUES (2);

INSERT INTO responsable (
    utilisateur_id
) VALUES (6);


-- Responsable Privilégié

INSERT INTO responsable_privilegie (
    responsable_id
) VALUES (6);


-- #### Commande #### --

INSERT INTO commande (
    etat,
    pizzeria_id,
    prix_total_ttc,
    adresse_id,
    date_heure,
    client_id,
    pizzaiolo_id
) VALUES
    (0,1, 76, 1, CURRENT_TIMESTAMP, 4,8),
    (5,1, 37, 3, CURRENT_TIMESTAMP, 7,1),
    (2,1, 176, 6, CURRENT_TIMESTAMP, 4,8);

-- #### Livraison #### --

INSERT INTO livraison (
    commande_numero,
    etat,
    livreur_id,
    instruction,
    date_heure
) VALUES
    (1, 0, 3, 'Frappez à la porte arrière', CURRENT_TIMESTAMP),
    (2, 1, 5, 'Laissez devant la porte', CURRENT_TIMESTAMP),
    (3, 0, 3, 'Manger la, cest cadeaux...', CURRENT_TIMESTAMP);

-- ### Stock ### --

INSERT INTO stock (
    ingredient_id,
    quantite,
    pizzeria_id
) VALUES
    (1, 1155, 2),
    (1, 617, 1),
    (2, 900, 2),
    (2, 1342, 1);

-- ### Ligne Commande ### --

INSERT INTO ligne_commande(
    commande_numero,
    quantite,
    pizza_id
) VALUES
    (1, 3, 2),
    (1, 1, 1),
    (2, 3, 2),
    (3, 2, 1);

-- ### Panier ### --

INSERT INTO panier (
    client_id
) VALUES
    (4),
    (7);

-- ### Element Panier  ### --

INSERT INTO element_panier (
    pizza_id,
    panier_id,
    quantite
) VALUES
    (1, 2, 3),
    (1, 1, 8),
    (2, 1, 1);
