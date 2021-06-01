--##############  CREATE TABLES  ##############--

CREATE SEQUENCE public.jour_ouvrable_id_seq;

CREATE TABLE public.jour_ouvrable (
                id INTEGER NOT NULL DEFAULT nextval('public.jour_ouvrable_id_seq'),
                jour VARCHAR NOT NULL,
                heure_ouverture TIME NOT NULL,
                heure_fermeture TIME NOT NULL,
                CONSTRAINT jour_ouvrable_pk PRIMARY KEY (id)
);


ALTER SEQUENCE public.jour_ouvrable_id_seq OWNED BY public.jour_ouvrable.id;

CREATE SEQUENCE public.pizza_id_seq;

CREATE TABLE public.pizza (
                id INTEGER NOT NULL DEFAULT nextval('public.pizza_id_seq'),
                nom VARCHAR NOT NULL,
                description TEXT NOT NULL,
                prix NUMERIC(5,2) NOT NULL,
                CONSTRAINT pizza_pk PRIMARY KEY (id)
);


ALTER SEQUENCE public.pizza_id_seq OWNED BY public.pizza.id;

CREATE SEQUENCE public.aide_memoire_id_seq;

CREATE TABLE public.aide_memoire (
                id INTEGER NOT NULL DEFAULT nextval('public.aide_memoire_id_seq'),
                pizza_id INTEGER NOT NULL,
                nom VARCHAR,
                contenu TEXT NOT NULL,
                CONSTRAINT aide_memoire_pk PRIMARY KEY (id)
);


ALTER SEQUENCE public.aide_memoire_id_seq OWNED BY public.aide_memoire.id;

CREATE SEQUENCE public.adresse_id_seq;

CREATE TABLE public.adresse (
                id INTEGER NOT NULL DEFAULT nextval('public.adresse_id_seq'),
                teritoire VARCHAR NOT NULL,
                ville VARCHAR NOT NULL,
                rue VARCHAR NOT NULL,
                code_postal VARCHAR NOT NULL,
                num_batiment INTEGER NOT NULL,
                pays VARCHAR NOT NULL,
                CONSTRAINT adresse_pk PRIMARY KEY (id)
);


ALTER SEQUENCE public.adresse_id_seq OWNED BY public.adresse.id;

CREATE SEQUENCE public.pizzeria_id_seq;

CREATE TABLE public.pizzeria (
                id INTEGER NOT NULL DEFAULT nextval('public.pizzeria_id_seq'),
                adresse_id INTEGER NOT NULL,
                taux_tax NUMERIC(5,3) NOT NULL,
                CONSTRAINT pizzeria_pk PRIMARY KEY (id)
);


ALTER SEQUENCE public.pizzeria_id_seq OWNED BY public.pizzeria.id;

CREATE UNIQUE INDEX pizzeria_idx
 ON public.pizzeria
 ( adresse_id );

CREATE TABLE public.pizzeria_jour_ouvrable (
                pizzeria_id INTEGER NOT NULL,
                jour_ouvrable_id INTEGER NOT NULL,
                CONSTRAINT pizzeria_jour_ouvrable_pk PRIMARY KEY (pizzeria_id, jour_ouvrable_id)
);


CREATE SEQUENCE public.utilisateur_id_seq;

CREATE TABLE public.utilisateur (
                id INTEGER NOT NULL DEFAULT nextval('public.utilisateur_id_seq'),
                nom VARCHAR NOT NULL,
                prenom VARCHAR NOT NULL,
                email VARCHAR NOT NULL,
                adresse_id INTEGER NOT NULL,
                numero_telephone NUMERIC(12) NOT NULL,
                pizzeria_id INTEGER NOT NULL,
                CONSTRAINT utilisateur_pk PRIMARY KEY (id)
);


ALTER SEQUENCE public.utilisateur_id_seq OWNED BY public.utilisateur.id;

CREATE UNIQUE INDEX utilisateur_idx
 ON public.utilisateur
 ( adresse_id );

CREATE TABLE public.responsable (
                utilisateur_id INTEGER NOT NULL,
                CONSTRAINT responsable_pk PRIMARY KEY (utilisateur_id)
);


CREATE UNIQUE INDEX responsable_idx
 ON public.responsable
 ( utilisateur_id );

CREATE TABLE public.responsable_privilegie (
                responsable_id INTEGER NOT NULL,
                CONSTRAINT responsable_privilegie_pk PRIMARY KEY (responsable_id)
);


CREATE TABLE public.livreur (
                utilisateur_id INTEGER NOT NULL,
                url_photo_permis_conduire VARCHAR NOT NULL,
                total_livraison_effectuee INTEGER NOT NULL,
                CONSTRAINT livreur_pk PRIMARY KEY (utilisateur_id)
);


CREATE UNIQUE INDEX livreur_idx
 ON public.livreur
 ( utilisateur_id );

CREATE TABLE public.pizzaiolo (
                utilisateur_id INTEGER NOT NULL,
                total_commande_preparee INTEGER NOT NULL,
                CONSTRAINT pizzaiolo_pk PRIMARY KEY (utilisateur_id)
);


CREATE UNIQUE INDEX pizzaiolo_idx
 ON public.pizzaiolo
 ( utilisateur_id );

CREATE TABLE public.client (
                utilisateur_id INTEGER NOT NULL,
                CONSTRAINT client_pk PRIMARY KEY (utilisateur_id)
);


CREATE UNIQUE INDEX client_idx
 ON public.client
 ( utilisateur_id );

CREATE SEQUENCE public.panier_id_seq;

CREATE TABLE public.panier (
                id INTEGER NOT NULL DEFAULT nextval('public.panier_id_seq'),
                client_id INTEGER NOT NULL,
                CONSTRAINT panier_pk PRIMARY KEY (id)
);


ALTER SEQUENCE public.panier_id_seq OWNED BY public.panier.id;

CREATE TABLE public.element_panier (
                panier_id INTEGER NOT NULL,
                pizza_id INTEGER NOT NULL,
                quantite INTEGER NOT NULL,
                CONSTRAINT element_panier_pk PRIMARY KEY (panier_id, pizza_id)
);


CREATE TABLE public.carte_credit (
                numero NUMERIC(16) NOT NULL,
                annee_expiration NUMERIC(4) NOT NULL,
                mois_expiration NUMERIC(2) NOT NULL,
                nom_proprietaire VARCHAR NOT NULL,
                client_id INTEGER NOT NULL,
                CONSTRAINT carte_credit_pk PRIMARY KEY (numero)
);


CREATE SEQUENCE public.commande_numero_seq;

CREATE TABLE public.commande (
                numero INTEGER NOT NULL DEFAULT nextval('public.commande_numero_seq'),
                date_heure TIMESTAMP NOT NULL,
                pizzeria_id INTEGER,
                prix_total_ttc INTEGER NOT NULL,
                etat SMALLINT NOT NULL,
                adresse_id INTEGER,
                client_id INTEGER,
                pizzaiolo_id INTEGER,
                CONSTRAINT commande_pk PRIMARY KEY (numero)
);


ALTER SEQUENCE public.commande_numero_seq OWNED BY public.commande.numero;

CREATE UNIQUE INDEX commande_idx
 ON public.commande
 ( adresse_id );

CREATE TABLE public.ligne_commande (
                pizza_id INTEGER NOT NULL,
                commande_numero INTEGER NOT NULL,
                quantite INTEGER NOT NULL,
                CONSTRAINT ligne_commande_pk PRIMARY KEY (pizza_id, commande_numero)
);


CREATE TABLE public.livraison (
                commande_numero INTEGER NOT NULL,
                livreur_id INTEGER NOT NULL,
                date_heure TIMESTAMP NOT NULL,
                etat SMALLINT NOT NULL,
                instruction VARCHAR NOT NULL,
                CONSTRAINT livraison_pk PRIMARY KEY (commande_numero, livreur_id)
);


CREATE SEQUENCE public.ingredient_id_seq;

CREATE TABLE public.ingredient (
                id INTEGER NOT NULL DEFAULT nextval('public.ingredient_id_seq'),
                nom VARCHAR NOT NULL,
                description TEXT NOT NULL,
                CONSTRAINT ingredient_pk PRIMARY KEY (id)
);


ALTER SEQUENCE public.ingredient_id_seq OWNED BY public.ingredient.id;

CREATE TABLE public.stock (
                pizzeria_id INTEGER NOT NULL,
                ingredient_id INTEGER NOT NULL,
                quantite INTEGER NOT NULL
);


CREATE TABLE public.ingredient_pizza_association (
                pizza_id INTEGER NOT NULL,
                ingredient_id INTEGER NOT NULL,
                CONSTRAINT ingredient_pizza_association_pk PRIMARY KEY (pizza_id, ingredient_id)
);


CREATE SEQUENCE public.image_pizza_id_seq;

CREATE TABLE public.image_pizza (
                id INTEGER NOT NULL DEFAULT nextval('public.image_pizza_id_seq'),
                url VARCHAR NOT NULL,
                pizza_id INTEGER NOT NULL,
                CONSTRAINT image_pizza_pk PRIMARY KEY (id)
);


ALTER SEQUENCE public.image_pizza_id_seq OWNED BY public.image_pizza.id;

ALTER TABLE public.pizzeria_jour_ouvrable ADD CONSTRAINT jour_ouvrable_pizzeria_jour_ouvrable_fk
FOREIGN KEY (jour_ouvrable_id)
REFERENCES public.jour_ouvrable (id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE public.aide_memoire ADD CONSTRAINT pizza_aide_memoire_fk
FOREIGN KEY (pizza_id)
REFERENCES public.pizza (id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE public.image_pizza ADD CONSTRAINT pizza_image_pizza_fk
FOREIGN KEY (pizza_id)
REFERENCES public.pizza (id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE public.ingredient_pizza_association ADD CONSTRAINT pizza_ingredient_pizza_ass_fk
FOREIGN KEY (pizza_id)
REFERENCES public.pizza (id)
ON DELETE CASCADE
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE public.element_panier ADD CONSTRAINT pizza_element_panier_fk
FOREIGN KEY (pizza_id)
REFERENCES public.pizza (id)
ON DELETE CASCADE
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE public.ligne_commande ADD CONSTRAINT pizza_ligne_commande_fk
FOREIGN KEY (pizza_id)
REFERENCES public.pizza (id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE public.commande ADD CONSTRAINT adresse_commande_fk1
FOREIGN KEY (adresse_id)
REFERENCES public.adresse (id)
ON DELETE SET NULL
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE public.utilisateur ADD CONSTRAINT adresse_utilisateur_fk
FOREIGN KEY (adresse_id)
REFERENCES public.adresse (id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE public.pizzeria ADD CONSTRAINT adresse_pizzeria_fk
FOREIGN KEY (adresse_id)
REFERENCES public.adresse (id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE public.commande ADD CONSTRAINT pizzeria_commande_fk
FOREIGN KEY (pizzeria_id)
REFERENCES public.pizzeria (id)
ON DELETE SET NULL
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE public.pizzeria_jour_ouvrable ADD CONSTRAINT pizzeria_pizzeria_jour_ouvrable_fk
FOREIGN KEY (pizzeria_id)
REFERENCES public.pizzeria (id)
ON DELETE CASCADE
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE public.stock ADD CONSTRAINT pizzeria_stock_fk
FOREIGN KEY (pizzeria_id)
REFERENCES public.pizzeria (id)
ON DELETE CASCADE
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE public.utilisateur ADD CONSTRAINT pizzeria_utilisateur_fk
FOREIGN KEY (pizzeria_id)
REFERENCES public.pizzeria (id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE public.client ADD CONSTRAINT utilisateur_client_fk
FOREIGN KEY (utilisateur_id)
REFERENCES public.utilisateur (id)
ON DELETE CASCADE
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE public.pizzaiolo ADD CONSTRAINT utilisateur_pizzaiolo_fk
FOREIGN KEY (utilisateur_id)
REFERENCES public.utilisateur (id)
ON DELETE CASCADE
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE public.livreur ADD CONSTRAINT utilisateur_livreur_fk
FOREIGN KEY (utilisateur_id)
REFERENCES public.utilisateur (id)
ON DELETE CASCADE
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE public.responsable ADD CONSTRAINT utilisateur_responsable_fk
FOREIGN KEY (utilisateur_id)
REFERENCES public.utilisateur (id)
ON DELETE CASCADE
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE public.responsable_privilegie ADD CONSTRAINT responsable_responsable_privilegie_fk
FOREIGN KEY (responsable_id)
REFERENCES public.responsable (utilisateur_id)
ON DELETE CASCADE
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE public.livraison ADD CONSTRAINT livreur_livraison_fk
FOREIGN KEY (livreur_id)
REFERENCES public.livreur (utilisateur_id)
ON DELETE SET NULL
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE public.commande ADD CONSTRAINT pizzaiolo_commande_fk
FOREIGN KEY (pizzaiolo_id)
REFERENCES public.pizzaiolo (utilisateur_id)
ON DELETE SET NULL
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE public.commande ADD CONSTRAINT client_commande_fk
FOREIGN KEY (client_id)
REFERENCES public.client (utilisateur_id)
ON DELETE SET NULL
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE public.carte_credit ADD CONSTRAINT client_carte_credit_fk
FOREIGN KEY (client_id)
REFERENCES public.client (utilisateur_id)
ON DELETE CASCADE
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE public.panier ADD CONSTRAINT client_panier_fk
FOREIGN KEY (client_id)
REFERENCES public.client (utilisateur_id)
ON DELETE CASCADE
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE public.element_panier ADD CONSTRAINT panier_element_panier_fk
FOREIGN KEY (panier_id)
REFERENCES public.panier (id)
ON DELETE CASCADE
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE public.livraison ADD CONSTRAINT commande_livraison_fk
FOREIGN KEY (commande_numero)
REFERENCES public.commande (numero)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE public.ligne_commande ADD CONSTRAINT commande_ligne_commande_fk
FOREIGN KEY (commande_numero)
REFERENCES public.commande (numero)
ON DELETE CASCADE
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE public.ingredient_pizza_association ADD CONSTRAINT ingredient_ingredient_pizza_ass_fk
FOREIGN KEY (ingredient_id)
REFERENCES public.ingredient (id)
ON DELETE RESTRICT
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE public.stock ADD CONSTRAINT ingredient_stock_fk
FOREIGN KEY (ingredient_id)
REFERENCES public.ingredient (id)
ON DELETE CASCADE
ON UPDATE NO ACTION
NOT DEFERRABLE;