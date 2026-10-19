-- =====================================================
-- DONNÉES INITIALES POUR ARCHIVES DÉPÊCHE
-- Mot de passe initial de démonstration : admin123
-- =====================================================

USE archives_depeche;

-- Comptes initiaux
INSERT INTO `users` (`organisation_id`, `role_id`, `nom`, `prenom`, `email`, `mot_de_passe`) VALUES
(NULL, 1, 'Super', 'Admin', 'superadmin@archives.dz', '$2a$10$YourHashHere'),
(1, 2, 'Admin', 'Dépêche', 'admin.depeche@archives.dz', '$2a$10$YourHashHere');

-- Catégories Dépêche
INSERT INTO `categories` (`organisation_id`, `nom`, `description`) VALUES
(1, 'Rédaction', 'Documents de rédaction'),
(1, 'Publicité', 'Documents publicitaires'),
(1, 'Administration', 'Documents administratifs'),
(1, 'Courriers Entrants', 'Courriers reçus'),
(1, 'Courriers Sortants', 'Courriers envoyés'),
(1, 'Juridique', 'Documents juridiques'),
(1, 'Finances', 'Documents financiers'),
(1, 'Ressources Humaines', 'Documents RH');

-- Salles Dépêche
INSERT INTO `salles` (`organisation_id`, `nom`, `description`) VALUES
(1, 'Salle Archives', 'Salle principale d''archives Dépêche'),
(1, 'Salle Réserve', 'Salle de réserve Dépêche');

-- Armoires
INSERT INTO `armoires` (`salle_id`, `code_armoire`, `nom`, `description`, `emplacement_physique`, `capacite`) VALUES
(1, 'D01', 'Armoire D01', 'Première armoire salle archives', 'Mur nord', 50),
(1, 'D02', 'Armoire D02', 'Deuxième armoire salle archives', 'Mur est', 50),
(1, 'D05', 'Armoire D05', 'Cinquième armoire salle archives', 'Mur sud', 50),
(2, 'D06', 'Armoire D06', 'Première armoire salle réserve', 'Mur ouest', 40);

-- Boîtes
INSERT INTO `boites` (`armoire_id`, `code_boite`, `nom`, `description`, `capacite`) VALUES
(1, 'B005', 'Boîte B005', 'Boîte rédaction', 30),
(2, 'B006', 'Boîte B006', 'Boîte publicité', 30),
(3, 'B010', 'Boîte B010', 'Boîte courriers', 30),
(4, 'B011', 'Boîte B011', 'Boîte archives de réserve', 30);
